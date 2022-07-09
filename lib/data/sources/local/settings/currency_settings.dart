import 'package:flutter_currency/data/models/currency_api.dart';
import 'package:flutter_currency/domain/entities/rate_settings.dart';

abstract class CurrencySettings{
  void createSettings(List<CurrencyApi> currencyInfo);
  List<RateSettings> fetchSettings();
  void updateSettings(List<RateSettings> settings);
}