import 'package:flutter_currency/data/models/currency_api.dart';
import 'package:flutter_currency/domain/entities/rate_settings.dart';
import 'package:rxdart/rxdart.dart';

abstract class CurrencySettings{
  void createSettings(List<CurrencyApi> currencyInfo);
  BehaviorSubject<List<RateSettings>> get subscribeSettings;
  void updateSettings(List<RateSettings> settings);
}