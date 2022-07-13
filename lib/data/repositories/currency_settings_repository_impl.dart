import 'package:flutter_currency/data/sources/local/settings/currency_settings.dart';
import 'package:flutter_currency/domain/entities/rate_settings.dart';
import 'package:flutter_currency/domain/repositories/currency_settings_repository.dart';
import 'package:get/get.dart';

class CurrencySettingsRepositoryImpl extends GetxService
    implements CurrencySettingsRepository {
  final CurrencySettings currencySettings;

  CurrencySettingsRepositoryImpl({
    required this.currencySettings,
  });

  @override
  Stream<List<RateSettings>> fetchSettings() => currencySettings
      .subscribeSettings();

  @override
  void saveSettings(List<RateSettings> settings) =>
      currencySettings.saveSettings(settings);
}
