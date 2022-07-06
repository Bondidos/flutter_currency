import 'package:flutter_currency/domain/entities/rate.dart';

abstract class CurrencySettings{
  Future<void> createSettings(List<Rate> rates);
  Map<String,dynamic> fetchSettings();
}