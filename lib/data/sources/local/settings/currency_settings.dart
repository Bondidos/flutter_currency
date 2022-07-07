import 'package:flutter_currency/domain/entities/rate.dart';
import 'package:flutter_currency/domain/entities/rate_settings.dart';

abstract class CurrencySettings{
  void createSettings(List<Rate> rates);
  List<RateSettings> fetchSettings();
  void updateSettings(List<RateSettings> settings);
}