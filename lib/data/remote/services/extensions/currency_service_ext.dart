import 'package:flutter_currency/data/models/rate_api.dart';

extension ListDynamicConverter on List<dynamic> {
  List<RateApi> toRateApiList() => map((e) => RateApi.fromJson(e)).toList();
}