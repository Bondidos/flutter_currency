import 'package:flutter_currency/domain/entities/currency_trend.dart';
import 'package:intl/intl.dart';

class TrendsState {
  final List<CurrencyTrend> trends;
  final double maxRate;
  final double minRate;
  final List<double> rateGrid;
  final List<String> dateGrid;
  final DateFormat _format = DateFormat("dd.MM.yyyy");

  TrendsState({
    required this.trends,
    required this.maxRate,
    required this.minRate,
  })  : rateGrid = [
          maxRate,
          (maxRate - minRate) / 4 * 3 + minRate,
          (maxRate - minRate) / 4 * 2 + minRate,
          (maxRate - minRate) / 4 + minRate,
          minRate,
        ],
        dateGrid = [] {
    dateGrid.addAll([
      _format.format(trends.first.date),
      _format.format(trends[trends.length ~/ 2].date),
      _format.format(trends.last.date),
    ]);
  }
}
