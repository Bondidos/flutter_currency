import 'package:flutter_currency/data/models/rate_api.dart';
import 'package:intl/intl.dart';

extension ListDynamicConverter on List<dynamic> {
  List<RateApi> toRateApiList() => map((e) => RateApi.fromJson(e)).toList();
}

extension DateToString on DateTime {
  String asString() {
    DateFormat format = DateFormat("dd.MM.yyyy");
    return format.format(this);
  }
}