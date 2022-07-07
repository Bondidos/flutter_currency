import 'package:flutter_currency/data/sources/local/settings/currency_settings.dart';
import 'package:flutter_currency/domain/entities/rate_settings.dart';
import 'package:flutter_currency/domain/repositories/currency_settings_repository.dart';

class CurrencySettingsRepositoryImpl implements CurrencySettingsRepository {
  final CurrencySettings currencySettings;

  CurrencySettingsRepositoryImpl({
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
