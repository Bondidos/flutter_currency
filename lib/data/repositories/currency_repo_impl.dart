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

  @override
  Stream<RatesOnDate?> fetchRates() {
    final Stream<List<RateSettings>> settings =
        currencySettings.subscribeSettings().switchMap(createIfEmpty);

    final Stream<RatesOnDate?> ratesOnDate =
        ratesDao.subscribe().switchMap(fetchDataFromCacheOrRemote);

    return CombineLatestStream.combine2(
        settings,
        ratesOnDate,
        (List<RateSettings> settings, RatesOnDate? rates) {
          if(settings.isEmpty || rates == null) return null;
          return rates.applySettings(settings);
        });
  }

  Stream<List<RateSettings>> createIfEmpty(List<RateSettings> settings) {
    if (settings.isEmpty) {
      _createSettings();
      return Stream<List<RateSettings>>.value(List.empty());
    }
    return Stream<List<RateSettings>>.value(settings);
  }

  Stream<RatesOnDate?> fetchDataFromCacheOrRemote(cachedData) {
    if (cachedData == null) {
      _fetchRatesThenCache();
      return Stream.value(null);
    } else {
      return Stream.value(cachedData);
    }
  }

  _fetchRatesThenCache() async {
    final RatesOnDate ratesOnDate = await currencyRemoteSource.fetchRates();
    ratesDao.saveRatesOnDate(ratesOnDate);
  }

  Future<void> _createSettings() async {
    final List<CurrencyApi> currencyInfoApi =
        await currencyRemoteSource.fetchCurrencyInfo();
    currencySettings.createSettings(currencyInfoApi);
  }
}
