import 'package:flutter_currency/domain/entities/rates_on_date.dart';

abstract class CurrencyRemoteSource{
  Future<RatesOnDate> fetchRates();
}