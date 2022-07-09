import 'package:flutter_currency/data/models/currency_api.dart';
import 'package:flutter_currency/data/models/rate_api.dart';

extension ListDynamicConverter on List<dynamic> {
  List<RateApi> toRateApiList() => map((e) => RateApi.fromJson(e)).toList();

  List<CurrencyApi> toCurrencyApi() =>
      map((e) => CurrencyApi.fromJson(e)).toList();
}
