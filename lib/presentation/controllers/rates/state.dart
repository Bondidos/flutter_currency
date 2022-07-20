import 'package:flutter_currency/domain/entities/rate.dart';
import 'package:flutter_currency/domain/entities/rates_on_date.dart';

class HomeState {
  final List<Rate> rates;
  final bool isTomorrowRatesExists;
  final String currentDate;
  final String alternativeDate;

  HomeState({
    required this.rates,
    required this.currentDate,
    required this.alternativeDate,
    required this.isTomorrowRatesExists,
  });

  factory HomeState.fromRatesOnDate(RatesOnDate currency) => HomeState(
        rates: currency.rates,
        currentDate: currency.currentDate,
        alternativeDate: currency.alternativeDate,
        isTomorrowRatesExists: currency.isTomorrowRatesExists,
      );
}
