import 'package:flutter_currency/domain/entities/rate.dart';

abstract class InMemoryCache{
  void cacheRates(List<Rate> rates);
  List<Rate> getCachedRates();
}