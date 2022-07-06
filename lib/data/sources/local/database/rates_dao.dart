import 'package:flutter_currency/domain/entities/rate.dart';

abstract class RatesDao {
  void saveRates(List<Rate> rates);
  List<Rate> getRates();
}