import 'package:flutter_currency/domain/entities/rate_settings.dart';

abstract class CurrencySettingsRepository{
  List<RateSettings> fetchSettings();
  void saveSettings(List<RateSettings> settings);
}