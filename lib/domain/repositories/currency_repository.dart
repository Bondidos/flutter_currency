import 'package:flutter_currency/domain/entities/rate.dart';

abstract class CurrencyRepository{
  Future<List<Rate>> fetchRates();
}