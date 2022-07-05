import 'package:flutter/material.dart';
import 'package:flutter_currency/data/local/settings/date_settings_impl.dart';
import 'package:flutter_currency/data/remote/remote_source_impl/currency_remote_source_impl.dart';
import 'package:flutter_currency/data/remote/source/api_provider.dart';
import 'package:flutter_currency/data/repositories/currency_repo_impl.dart';
import 'package:flutter_currency/data/sources/local/settings/date_settings.dart';
import 'package:flutter_currency/data/sources/remote/currency_remote_source.dart';
import 'package:flutter_currency/domain/repositories/currency_repository.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DependencyCreator {
  static init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await initSources();
    createSources();
    initServices();
  }
}
initSources() async {
  Get.lazyPut(() => APIProvider(), fenix: true);
  await GetStorage.init('Settings');
  Get.lazyPut<GetStorage>(() => GetStorage('Settings'));
}

createSources(){
  Get.lazyPut<CurrencyRemoteSource>(
          () => CurrencyRemoteSourceImpl(apiProvider: Get.find()));
}
initServices() {
  Get.lazyPut<DateSettings>(() => DateSettingsImpl(storage: Get.find()));
  Get.lazyPut<CurrencyRepository>(() => CurrencyRepoImpl(currencyRemoteSource: Get.find()));
}