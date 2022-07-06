import 'package:flutter_currency/data/sources/local/cache/in_memory_cache.dart';
import 'package:flutter_currency/data/sources/local/settings/date_settings.dart';
import 'package:flutter_currency/domain/entities/rate.dart';
import 'package:get_storage/get_storage.dart';

const ratesList = 'rates';

class InMemoryCacheImpl implements InMemoryCache {
  final GetStorage cache;
  final DateSettings dateSettings;

  InMemoryCacheImpl({
    required this.cache,
    required this.dateSettings,
  });

  @override
  void cacheRates(List<Rate> rates) => cache.writeInMemory(ratesList, rates);

  @override
  List<Rate> getCachedRates() {
    if(dateSettings.isCurrentDateActual) return cache.read(ratesList) ?? [];
    return [];
  }
}
