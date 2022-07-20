import 'package:flutter_currency/data/models/currency_api.dart';
import 'package:flutter_currency/data/models/currency_trend_api.dart';
import 'package:flutter_currency/domain/entities/rates_on_date.dart';

abstract class CurrencyRemoteSource {
  Future<RatesOnDate> fetchRates();

  Future<List<CurrencyApi>> fetchCurrencyInfo();

  Future<List<CurrencyTrendApi>> fetchTrendsMonth(int id);

  Future<List<CurrencyTrendApi>> fetchTrendsSixMonths(int id);
}
