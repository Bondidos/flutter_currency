import 'package:flutter_currency/data/models/rate_api.dart';

abstract class CurrencyService{
  List<RateApi> fetchTodayRates();
  List<RateApi> fetchTomorrowRates();
  List<RateApi> fetchYesterdayRates();
}