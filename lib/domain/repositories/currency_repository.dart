import 'package:flutter_currency/domain/entities/rates_on_date.dart';

abstract class CurrencyRepository{
  Future<RatesOnDate> fetchRates();

}