import 'package:flutter_currency/data/models/currency_api.dart';

const everyDay = 0;

extension Filter on List<CurrencyApi> {
  List<CurrencyApi> filterOld() {
    DateTime now = DateTime.now();
    return where((element) {
      var endDate = DateTime.parse(element.curDateEnd);
      return now.isBefore(endDate) && element.curPeriodicity == everyDay;
    }).toList();
  }
}
