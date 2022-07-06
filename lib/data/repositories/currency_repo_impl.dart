import 'package:flutter_currency/data/local/settings/extensions/date_settings_ext.dart';
import 'package:flutter_currency/data/sources/local/cache/in_memory_cache.dart';
import 'package:flutter_currency/data/sources/local/settings/currency_settings.dart';
import 'package:flutter_currency/data/sources/local/settings/date_settings.dart';
import 'package:flutter_currency/data/sources/remote/currency_remote_source.dart';
import 'package:flutter_currency/domain/entities/rate.dart';
import 'package:flutter_currency/domain/entities/rates_on_date.dart';
import 'package:flutter_currency/domain/repositories/currency_repository.dart';
import 'package:get/get.dart';

const initialSettingsLength = 3;

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

  //todo refactor this class
  //todo read / write settings
  @override
  Future<RatesOnDate> fetchRates() async {
    final List<Rate> rates = await currencyRemoteSource.fetchRates();
    // inMemoryCache.cacheRates(rates);
    final List<Rate> ratesFiltered = _syncWithSettings(rates);
    return RatesOnDate(
      rates: ratesFiltered,
      currentDate: dateSettings.currentDate.asString(),
      alternativeDate: dateSettings.alternativeDate.asString(),
      isTomorrowRatesExists: dateSettings.isTomorrowRatesExists,
    );
  }

  List<Rate> _syncWithSettings(List<Rate> rates) {
    Map<String, dynamic> settings = currencySettings.fetchSettings();
    if (settings.length == initialSettingsLength) {
      _createFullSettings(rates.createSettings());
    }
    return rates
        .where((element) => settings[element.curId.toString()] == true)
        .toList();
  }

  void _createFullSettings(Map<String, bool> settings) =>
      currencySettings.createSettings(settings);
}

extension CreateSettings on List<Rate> {
  Map<String, bool> createSettings() =>
      {for (var item in this) item.curId.toString(): false};
}
