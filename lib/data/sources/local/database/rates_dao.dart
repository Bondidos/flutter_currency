import 'package:flutter_currency/domain/entities/rates_on_date.dart';
import 'package:rxdart/rxdart.dart';

abstract class RatesDao{
  void saveRatesOnDate(RatesOnDate rates);
  Stream<RatesOnDate?> subscribe();
}