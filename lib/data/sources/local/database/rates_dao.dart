import 'package:flutter_currency/domain/entities/rates_on_date.dart';

abstract class RatesDao{
  void saveRatesOnDate(RatesOnDate rates);
  RatesOnDate? getRates();
}