import 'package:flutter_currency/data/models/currency_api.dart';
import 'package:flutter_currency/data/models/rate_api.dart';
import 'package:flutter_currency/data/remote/services/extensions/currency_service_ext.dart';
import 'package:flutter_currency/data/remote/source/api_provider.dart';
import 'package:flutter_currency/data/remote/source/apis/currency_api.dart';
import 'package:flutter_currency/data/remote/source/apis/extensions/currency_info_api.dart';
import 'package:flutter_currency/data/sources/remote/services/currency_service.dart';

class CurrencyServiceImpl implements CurrencyService {
  final APIProvider apiProvider;

  CurrencyServiceImpl({required this.apiProvider});

  @override
  Future<List<RateApi>> fetchTodayRates() =>
      _fetchRates(onDay: CurrencyRatesApi.today());

  @override
  Future<List<RateApi>> fetchTomorrowRates() =>
      _fetchRates(onDay: CurrencyRatesApi.tomorrow());

  @override
  Future<List<RateApi>> fetchYesterdayRates() =>
      _fetchRates(onDay: CurrencyRatesApi.yesterday());

  @override
  Future<List<CurrencyApi>> fetchCurrencyInfo() =>
      _fetchInfo(request: CurrencyInfoApi());

  Future<List<RateApi>> _fetchRates({required CurrencyRatesApi onDay}) async {
    List<dynamic> response = await apiProvider.request(onDay);
    return response.toRateApiList();
  }

  Future<List<CurrencyApi>> _fetchInfo({required CurrencyInfoApi request}) async {
    List response = await apiProvider.request(request);
    return response.toCurrencyApi();
  }
}
