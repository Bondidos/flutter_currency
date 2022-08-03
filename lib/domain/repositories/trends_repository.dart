import 'package:flutter_currency/domain/entities/currency_trend.dart';

abstract class CurrencyTrendsRepository{
  void monthPeriod();
  void sixMonthPeriod(int curId);
  Stream<List<CurrencyTrend>?> subscribeTrends();
}