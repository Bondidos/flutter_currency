import 'package:flutter_currency/data/models/currency_api.dart';
import 'package:flutter_currency/domain/entities/rate_settings.dart';
import 'package:hive/hive.dart';

abstract class CurrencySettings{
  void createSettings(List<CurrencyApi> currencyInfo);
  Stream<List<RateSettings>> get subscribeSettings;
  void updateSettings(List<RateSettings> settings);
}