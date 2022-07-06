import 'package:flutter_currency/data/sources/local/cache/in_memory_cache.dart';
import 'package:flutter_currency/data/sources/local/settings/currency_settings.dart';
import 'package:flutter_currency/domain/entities/rate_settings.dart';
import 'package:flutter_currency/domain/repositories/currency_settings_repository.dart';

class CurrencySettingsRepositoryImpl implements CurrencySettingsRepository {
  final InMemoryCache inMemoryCache;
  final CurrencySettings currencySettings;

  CurrencySettingsRepositoryImpl({
    required this.inMemoryCache,
    required this.currencySettings,
  });

  @override
  List<RateSettings> fetchSettings() {
    // TODO: implement fetchSettings
    throw UnimplementedError();
  }

  @override
  void saveSettings(Map<String, bool> settings) {
    // TODO: implement saveSettings
  }
}
