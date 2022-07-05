import 'package:flutter_currency/domain/entities/rate.dart';
import 'package:flutter_currency/domain/entities/rate_settings.dart';

abstract class CurrencySettings{
  Future<void> createFromRates(List<Rate> rates);
  Future<List<RateSettings>> fetchSettings(List<RateSettings> settings);
}