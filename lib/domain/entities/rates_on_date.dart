import 'package:flutter_currency/domain/entities/rate.dart';

class RatesOnDate {
  final List<Rate> rates;
  final String currentDate;
  final String alternativeDate;
  final bool isTomorrowRatesExists;

  RatesOnDate({
    required this.rates,
    required this.currentDate,
    required this.alternativeDate,
    required this.isTomorrowRatesExists,
  });
}
