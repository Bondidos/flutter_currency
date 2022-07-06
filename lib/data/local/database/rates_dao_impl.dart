import 'package:flutter_currency/data/sources/local/database/rates_dao.dart';
import 'package:flutter_currency/domain/entities/rate.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

const rateListKey = 'rateListKey';

class RatesDaoImpl implements RatesDao{
  final Box<List<Rate>> ratesBox;

  RatesDaoImpl({required this.ratesBox});

  @override
  List<Rate> getRates() {
    return ratesBox.get(rateListKey) ?? [];
  }

  @override
  void saveRates(List<Rate> rates) {
    ratesBox.put(rateListKey, rates);
  }
}