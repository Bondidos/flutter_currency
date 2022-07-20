import 'package:flutter_currency/data/remote/source/apis/currency_trends_api.dart';
import 'package:intl/intl.dart';

extension PeriodToDates on TrendPeriod {
  String getStartDate() {
    DateFormat format = DateFormat("MM.dd.yyyy");
    DateTime now = DateTime.now();
    switch (this) {
      case TrendPeriod.month:
        return format.format(now.subtract(const Duration(days: 30)));
      case TrendPeriod.sixMonths:
        return format.format(now.subtract(const Duration(days: 180)));
    }
  }

  String getEndDate() {
    DateFormat format = DateFormat("MM.dd.yyyy");
    DateTime now = DateTime.now();
    return format.format(now);
  }
}
