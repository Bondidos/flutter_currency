import 'package:flutter_currency/domain/entities/rate.dart';
import 'package:flutter_currency/domain/entities/rates_on_date.dart';

abstract class RatesDatastore{
  void saveRatesOnDate(RatesOnDate rates);
  Stream<RatesOnDate?> subscribe();
  List<Rate> fetchCurrencies();
}