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

  late Stream<RatesOnDate> ratesOnDateStream;
  late Stream<List<RateSettings>> settingsStream;

  late Stream<RatesOnDate?> result;

  @override
  void onInit() {
    ratesOnDateStream = Stream.fromFuture(_fetchRatesFromCacheOrRemote());
    settingsStream = currencySettings.subscribeSettings;
    result = CombineLatestStream.combine2(
        ratesOnDateStream,
        settingsStream,
        (RatesOnDate rates, List<RateSettings> settings) {
          if(settings.isEmpty) {
        _createSettings();
        return null;
      }
      return rates.applySettings(settings);
        });
    super.onInit();
  }

  @override
  Stream<RatesOnDate?> fetchRates() {
    return result;
  }

  Future<RatesOnDate> _fetchRatesFromCacheOrRemote() async {
    // _createSettings();//todo logic

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
}
