import 'package:flutter_currency/domain/entities/rate.dart';

abstract class CurrencyRemoteSource{
  Future<List<Rate>> fetchRates();
}