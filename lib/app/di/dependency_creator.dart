import 'package:flutter/material.dart';
import 'package:flutter_currency/data/local/database/dao/rates_dao_impl.dart';
import 'package:flutter_currency/data/local/settings/converter_settings_store_impl.dart';
import 'package:flutter_currency/data/local/settings/currency_settings_impl.dart';
import 'package:flutter_currency/data/local/settings/date_settings_impl.dart';
import 'package:flutter_currency/data/remote/remote_source_impl/currency_remote_source_impl.dart';
import 'package:flutter_currency/data/remote/services/currency_service_impl.dart';
import 'package:flutter_currency/data/remote/source/api_provider.dart';
import 'package:flutter_currency/data/repositories/converter_repo_impl.dart';
import 'package:flutter_currency/data/repositories/currency_repo_impl.dart';
import 'package:flutter_currency/data/repositories/currency_settings_repository_impl.dart';
import 'package:flutter_currency/data/repositories/currency_trends_repository_impl.dart';
import 'package:flutter_currency/data/sources/local/database/rates_dao.dart';
import 'package:flutter_currency/data/sources/local/settings/converter_settings_store.dart';
import 'package:flutter_currency/data/sources/local/settings/currency_settings.dart';
import 'package:flutter_currency/data/sources/local/settings/date_settings.dart';
import 'package:flutter_currency/data/sources/remote/currency_remote_source.dart';
import 'package:flutter_currency/data/sources/remote/services/currency_service.dart';
import 'package:flutter_currency/domain/entities/converter_settings.dart';
import 'package:flutter_currency/domain/entities/rate.dart';
import 'package:flutter_currency/domain/entities/rate_settings.dart';
import 'package:flutter_currency/domain/entities/rates_on_date.dart';
import 'package:flutter_currency/domain/repositories/converter_repository.dart';
import 'package:flutter_currency/domain/repositories/currency_repository.dart';
import 'package:flutter_currency/domain/repositories/currency_settings_repository.dart';
import 'package:flutter_currency/domain/repositories/trends_repository.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

const dateSettingsTag = 'DateSettings';
const currencySettingsTag = 'CurrencySettings';
// const inMemoryCache = 'InMemoryCache';
const ratesBox = "ratesBox";
const settingsBox = 'settingsBox';
const ratesOnDate = 'ratesOnDate';
const converterSettings = 'converter settings';

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
  await Hive.initFlutter();
  Hive.registerAdapter<Rate>(RateAdapter());
  Hive.registerAdapter<RatesOnDate>(RatesOnDateAdapter());
  Hive.registerAdapter<RateSettings>(RateSettingsAdapter());
  Hive.registerAdapter<ConverterSettings>(ConverterSettingsAdapter());
  await Hive.openBox<RatesOnDate>(ratesOnDate);
  await Hive.openBox<List>(settingsBox);
  await Hive.openBox<ConverterSettings>(converterSettings);
}

createSources() {
  Get.lazyPut(() => APIProvider());
  Get.lazyPut<GetStorage>(() => GetStorage(dateSettingsTag),
      tag: dateSettingsTag);
  Get.lazyPut(() => Hive.box<RatesOnDate>(ratesOnDate));
  Get.lazyPut(() => Hive.box<List>(settingsBox));
  Get.lazyPut(() => Hive.box<ConverterSettings>(converterSettings));
}

putImplementations() {
  Get.lazyPut<CurrencyRemoteSource>(() => CurrencyRemoteSourceImpl(
        currencyService: Get.find(),
        dateSettings: Get.find(),
      ));

  Get.lazyPut<DateSettings>(() => DateSettingsImpl(
        storage: Get.find(tag: dateSettingsTag),
      ));

  Get.lazyPut<RatesDatastore>(() => RatesDatastoreImpl(
        dateSettings: Get.find(),
        ratesBox: Get.find(),
      ));
  Get.lazyPut<CurrencySettings>(() => CurrencySettingsImpl(
        currencySettings: Get.find(),
      ));

  Get.lazyPut<ConverterSettingsStore>(
      () => ConverterSettingsStoreImpl(store: Get.find()));

  Get.lazyPut<ConverterRepository>(() => ConverterRepositoryImpl(
        ratesDao: Get.find(),
        settingsStore: Get.find(),
      ));
}

putServices() {
  Get.lazyPut<CurrencyRepository>(() => CurrencyRepoImpl(
        currencyRemoteSource: Get.find(),
        currencySettings: Get.find(),
        ratesDao: Get.find(),
      ));
  Get.lazyPut<CurrencyService>(() => CurrencyServiceImpl(
        apiProvider: Get.find(),
        dateSettings: Get.find(),
      ));
  Get.lazyPut<CurrencySettingsRepository>(() => CurrencySettingsRepositoryImpl(
        currencySettings: Get.find(),
      ));
  Get.lazyPut<CurrencyTrendsRepository>(() => CurrencyTrendsRepositoryImpl(
        remoteSource: Get.find(),
        settingsStore: Get.find(),
      ));
}
