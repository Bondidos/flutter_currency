import 'package:flutter_currency/data/models/currency_api.dart';
import 'package:flutter_currency/domain/entities/rate_settings.dart';

abstract class CurrencySettings{
  void createSettings(List<CurrencyApi> currencyInfo);
  Stream<List<RateSettings>> subscribeSettings();
  void saveSettings(List<RateSettings> settings);
}