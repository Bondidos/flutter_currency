import 'package:flutter_currency/data/local/settings/extensions/date_settings_ext.dart';
import 'package:flutter_currency/data/sources/local/cache/in_memory_cache.dart';
import 'package:flutter_currency/data/sources/local/settings/currency_settings.dart';
import 'package:flutter_currency/data/sources/local/settings/date_settings.dart';
import 'package:flutter_currency/data/sources/remote/currency_remote_source.dart';
import 'package:flutter_currency/domain/entities/rate.dart';
import 'package:flutter_currency/domain/entities/rates_on_date.dart';
import 'package:flutter_currency/domain/repositories/currency_repository.dart';
import 'package:get/get.dart';

class CurrencyRepoImpl extends GetxService implements CurrencyRepository {
  final CurrencyRemoteSource currencyRemoteSource;
  final DateSettings dateSettings;
  final CurrencySettings currencySettings;
  final InMemoryCache inMemoryCache;

  CurrencyRepoImpl({
    required this.currencyRemoteSource,
    required this.dateSettings,
    required this.currencySettings,
    required this.inMemoryCache,
  });

  @override
  Future<RatesOnDate> fetchRates() async {
    final List<Rate> rates = await _fetchRatesFromCacheOrRemote();
    final List<Rate> ratesFiltered = await _syncWithSettings(rates);
    return RatesOnDate(
      rates: ratesFiltered,
      currentDate: dateSettings.currentDate.asString(),
      alternativeDate: dateSettings.alternativeDate.asString(),
      isTomorrowRatesExists: dateSettings.isTomorrowRatesExists,
    );
  }

  Future<List<Rate>> _fetchRatesFromCacheOrRemote() async {
    final List<Rate> cachedRates = inMemoryCache.getCachedRates();
    if (cachedRates.isEmpty) return _fetchRatesThenCache();
    return cachedRates;
  }

  Future<List<Rate>> _fetchRatesThenCache() async {
    final List<Rate> ratesApi = await currencyRemoteSource.fetchRates();
    inMemoryCache.cacheRates(ratesApi);
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
