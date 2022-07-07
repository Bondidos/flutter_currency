import 'package:flutter_currency/data/sources/local/database/rates_dao.dart';
import 'package:flutter_currency/data/sources/local/settings/currency_settings.dart';
import 'package:flutter_currency/data/sources/remote/currency_remote_source.dart';
import 'package:flutter_currency/domain/entities/rate.dart';
import 'package:flutter_currency/domain/entities/rates_on_date.dart';
import 'package:flutter_currency/domain/repositories/currency_repository.dart';
import 'package:get/get.dart';

class CurrencyRepoImpl extends GetxService implements CurrencyRepository {
  final CurrencyRemoteSource currencyRemoteSource;
  final CurrencySettings currencySettings;
  final RatesDao ratesDatabase;

  CurrencyRepoImpl({
    required this.currencyRemoteSource,
    required this.currencySettings,
    required this.ratesDatabase,
  });

  /**
   * there no sense to store web response in cache,
   * becourse of it will be transformated to RatesOnDate any time.
   * Better to store RatesOnDate? and check store for actual data on Date
   */

  @override
  Future<RatesOnDate> fetchRates() async {

    //todo here i should to receive RatesOnDate? no matter from where (cache or remote)
    final List<Rate> rates = await _fetchRatesFromCacheOrRemote();
    final List<Rate> ratesFiltered = await _syncWithSettings(rates);
    return
  }

  Future<List<Rate>> _fetchRatesFromCacheOrRemote() async {
    final List<Rate> cachedRates = [];//inMemoryCache.getCachedRates();
    if (cachedRates.isEmpty) return _fetchRatesThenCache();
    return cachedRates;
  }

  Future<List<Rate>> _fetchRatesThenCache() async {
    final List<Rate> ratesApi = await currencyRemoteSource.fetchRates();
    // inMemoryCache.cacheRates(ratesApi);
    return ratesApi;
  }

  Future<List<Rate>> _syncWithSettings(List<Rate> rates) async {
    Map<String, dynamic> settings = currencySettings.fetchSettings();
    if (settings.isEmpty && settings.length != rates.length) {
      await currencySettings.createSettings(rates);
      settings = currencySettings.fetchSettings();
    }
    return rates
        .where((element) => settings[element.curId.toString()] == true)
        .toList();
  }
}
