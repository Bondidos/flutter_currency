import 'package:flutter_currency/data/sources/local/cache/in_memory_cache.dart';
import 'package:flutter_currency/domain/entities/rate.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

const ratesList = 'rates';

class InMemoryCacheImpl extends GetxService implements InMemoryCache{
  final GetStorage cache;
  InMemoryCacheImpl({required this.cache});

  @override
  void cacheRates(List<Rate> rates) => cache.writeInMemory(ratesList, rates);

  @override
  List<Rate>? getCachedRates()  => cache.read(ratesList);

}