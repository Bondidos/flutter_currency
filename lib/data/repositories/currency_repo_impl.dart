import 'package:flutter_currency/data/models/currency_api.dart';
import 'package:flutter_currency/data/repositories/extensions/currency_repo_ext.dart';
import 'package:flutter_currency/data/sources/local/database/rates_dao.dart';
import 'package:flutter_currency/data/sources/local/settings/currency_settings.dart';
import 'package:flutter_currency/data/sources/remote/currency_remote_source.dart';
import 'package:flutter_currency/domain/entities/rate_settings.dart';
import 'package:flutter_currency/domain/entities/rates_on_date.dart';
import 'package:flutter_currency/domain/repositories/currency_repository.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class CurrencyRepoImpl extends GetxService implements CurrencyRepository {
  final CurrencyRemoteSource currencyRemoteSource;
  final CurrencySettings currencySettings;
  final RatesDao ratesDao;

  CurrencyRepoImpl({
    required this.currencyRemoteSource,
    required this.currencySettings,
    required this.ratesDao,
  });

  BehaviorSubject<RatesOnDate>? ratesOnDateStream;
  BehaviorSubject<List<RateSettings>>? settingsStream;
  BehaviorSubject<RatesOnDate>? cacheStream;

  late Stream<RatesOnDate?> result;

  @override
  void onInit() {
    ratesOnDateStream = BehaviorSubject.fromFuture(_fetchRatesFromCacheOrRemote());
    settingsStream = currencySettings.subscribeSettings;
    super.onInit();
  }

  @override
  Stream<RatesOnDate?> fetchRates() {
    return result = CombineLatestStream.combine2(
        ratesOnDateStream ?? const Stream<RatesOnDate>.empty(),
        settingsStream ?? const Stream<List<RateSettings>>.empty(),
        (RatesOnDate rates, List<RateSettings> settings) {
      if (settings.isEmpty) {
        _createSettings();
        return null;
      }
      return rates.applySettings(settings);
    });
  }

  Future<RatesOnDate> _fetchRatesFromCacheOrRemote() async {
    final RatesOnDate? ratesOnDate = ratesDao.getRates();
    if (ratesOnDate == null) return _fetchRatesThenCache();
    return ratesOnDate;
  }

  Future<RatesOnDate> _fetchRatesThenCache() async {
    final RatesOnDate ratesOnDate = await currencyRemoteSource.fetchRates();
    ratesDao.saveRatesOnDate(ratesOnDate);
    return ratesOnDate;
  }

  Future<void> _createSettings() async {
    final List<CurrencyApi> currencyInfoApi =
        await currencyRemoteSource.fetchCurrencyInfo();
    currencySettings.createSettings(currencyInfoApi);
  }

  @override
  void onClose() {
    ratesOnDateStream = null;
    settingsStream = null;
    cacheStream = null;
    super.onClose();
  }
}
