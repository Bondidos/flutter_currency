import 'package:flutter_currency/data/models/currency_api.dart';
import 'package:intl/intl.dart';

const everyDay = 0;

extension DateToString on DateTime {
  String asString() {
    DateFormat format = DateFormat("dd.MM.yyyy");
    return format.format(this);
  }
}

extension Filter on List<CurrencyApi> {
  List<CurrencyApi> filterOld() {
    DateTime now = DateTime.now();
    return where((element) {
      var endDate = DateTime.parse(element.curDateEnd);
      return now.isBefore(endDate) && element.curPeriodicity == everyDay;
    }).toList();
  }
}
