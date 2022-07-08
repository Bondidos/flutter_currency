import 'package:flutter_currency/domain/entities/rate.dart';
import 'package:hive_flutter/adapters.dart';

part 'adapters/rates_on_date.g.dart';

@HiveType(typeId: 2)
class RatesOnDate {
  @HiveField(0)
  final List<Rate> rates;
  @HiveField(1)
  final String currentDate;
  @HiveField(2)
  final String alternativeDate;
  @HiveField(3)
  final bool isTomorrowRatesExists;

  RatesOnDate({
    required this.rates,
    required this.currentDate,
    required this.alternativeDate,
    required this.isTomorrowRatesExists,
  });
}
