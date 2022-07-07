import 'package:flutter/material.dart';
import 'package:flutter_currency/data/local/cache/in_memory_cache_impl.dart';
import 'package:flutter_currency/data/local/database/dao/rates_dao_impl.dart';
import 'package:flutter_currency/data/local/settings/currency_settings_impl.dart';
import 'package:flutter_currency/data/local/settings/date_settings_impl.dart';
import 'package:flutter_currency/data/remote/remote_source_impl/currency_remote_source_impl.dart';
import 'package:flutter_currency/data/remote/source/api_provider.dart';
import 'package:flutter_currency/data/repositories/currency_repo_impl.dart';
import 'package:flutter_currency/data/sources/local/cache/in_memory_cache.dart';
import 'package:flutter_currency/data/sources/local/database/rates_dao.dart';
import 'package:flutter_currency/data/sources/local/settings/currency_settings.dart';
import 'package:flutter_currency/data/sources/local/settings/date_settings.dart';
import 'package:flutter_currency/data/sources/remote/currency_remote_source.dart';
import 'package:flutter_currency/domain/entities/rate.dart';
import 'package:flutter_currency/domain/entities/rate_settings.dart';
import 'package:flutter_currency/domain/entities/rates_on_date.dart';
import 'package:flutter_currency/domain/repositories/currency_repository.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

const dateSettingsTag = 'DateSettings';
const currencySettingsTag = 'CurrencySettings';
const inMemoryCache = 'InMemoryCache';
const ratesBox = "ratesBox";
const settingsBox = 'settingsBox';
const ratesOnDate = 'ratesOnDate';

class DependencyCreator {
  static init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await initSources();
    createSources();
    putImplementations();
    putServices();
  }
}

initSources() async {
  await GetStorage.init(dateSettingsTag);
  await GetStorage.init(currencySettingsTag);
  // await GetStorage.init(inMemoryCache);
  await Hive.initFlutter();
  Hive.registerAdapter<Rate>(RateAdapter());
  Hive.registerAdapter<RatesOnDate>(RatesOnDateAdapter());
  Hive.registerAdapter<RateSettings>(RateSettingsAdapter());
  // await Hive.openBox<List<Rate>>(ratesBox);
  await Hive.openBox<RatesOnDate>(ratesOnDate);
  // await Hive.openBox<RateSettings>(settingsBox);
}

createSources() {
  Get.lazyPut(() => APIProvider());
  Get.lazyPut<GetStorage>(() => GetStorage(dateSettingsTag),
      tag: dateSettingsTag);
  Get.lazyPut<GetStorage>(() => GetStorage(currencySettingsTag),
      tag: currencySettingsTag);
  // Get.lazyPut<GetStorage>(() => GetStorage(inMemoryCache), tag: inMemoryCache);
  // Get.lazyPut(() => Hive.box<List<Rate>>(ratesBox));
  Get.lazyPut(() => Hive.box<List<RatesOnDate>>(ratesOnDate));
  // Get.lazyPut(() => Hive.box<List<RateSettings>>(settingsBox));
}

putImplementations() {
  Get.lazyPut<CurrencyRemoteSource>(() => CurrencyRemoteSourceImpl(
        currencyService: null,
        dateSettings: null,
      ));
  Get.lazyPut<DateSettings>(() => DateSettingsImpl(
        storage: Get.find(tag: dateSettingsTag),
      ));

  Get.lazyPut<RatesDao>(() => RatesDaoImpl(
        dateSettings: Get.find(),
        ratesBox: null,
      ));
  Get.lazyPut<CurrencySettings>(() => CurrencySettingsImpl(
        currencySettings: Get.find(tag: currencySettingsTag),
      ));

  Get.lazyPut<RatesDao>(() => RatesDaoImpl(
        ratesBox: Get.find(),
        dateSettings: null,
      ));
}

putServices() {
  Get.lazyPut<CurrencyRepository>(
    () => CurrencyRepoImpl(
      currencyRemoteSource: Get.find(),
      currencySettings: Get.find(),
      ratesDao: Get.find(),
    ),
  );
}
