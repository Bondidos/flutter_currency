import 'package:flutter_currency/data/models/currency_api.dart';
import 'package:flutter_currency/domain/entities/rates_on_date.dart';

abstract class CurrencyRemoteSource{
  Future<RatesOnDate> fetchRates();
  Future<List<CurrencyApi>> fetchCurrencyInfo();
}