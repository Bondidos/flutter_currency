import 'package:flutter_currency/data/models/currency_api.dart';
import 'package:flutter_currency/data/models/rate_api.dart';

abstract class CurrencyService{
  Future<List<RateApi>> fetchTodayRates();
  Future<List<RateApi>> fetchTomorrowRates();
  Future<List<RateApi>> fetchYesterdayRates();
  Future<List<CurrencyApi>> fetchCurrencyInfo();
}