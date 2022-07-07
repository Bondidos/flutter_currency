import 'package:flutter_currency/data/models/rate_api.dart';
import 'package:flutter_currency/data/remote/source/api_provider.dart';
import 'package:flutter_currency/data/sources/remote/services/currency_service.dart';

class CurrencyServiceImpl implements CurrencyService{
  final APIProvider apiProvider;


  @override
  List<RateApi> fetchTodayRates() {
    // TODO: implement fetchTodayRates
    throw UnimplementedError();
  }

  @override
  List<RateApi> fetchTomorrowRates() {
    // TODO: implement fetchTomorrowRates
    throw UnimplementedError();
  }

  @override
  List<RateApi> fetchYesterdayRates() {
    // TODO: implement fetchYesterdayRates
    throw UnimplementedError();
  }

}