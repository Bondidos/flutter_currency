import 'package:flutter_currency/domain/use_cases/fetch_converter_data.dart';
import 'package:flutter_currency/domain/use_cases/fetch_currency_rates_use_case.dart';
import 'package:flutter_currency/domain/use_cases/save_converter_settings.dart';
import 'package:flutter_currency/domain/use_cases/subscribe_converter_settings.dart';
import 'package:flutter_currency/presentation/controllers/converter/logic.dart';
import 'package:flutter_currency/presentation/controllers/rates/logic.dart';
import 'package:get/get.dart';

import 'logic.dart';

class BottomNavigationBinding extends Bindings {

  @override
  void dependencies() {
    _bottomNavPageDependencies();
    _homeDependencies();
    _converterDependencies();
  }
  void _bottomNavPageDependencies(){
    Get.lazyPut(() => BottomNavigationLogic());
  }

  void _homeDependencies(){
    Get.lazyPut(() => FetchCurrencyRates(repository: Get.find()));
    Get.lazyPut(() => RatesLogic(fetchRatesUseCase: Get.find()));
  }

  void _converterDependencies(){
    Get.lazyPut(() => FetchConverterData(repository: Get.find()));
    Get.lazyPut(() => SaveConverterSettings(Get.find()));
    Get.lazyPut(() => SubscribeConverterSettings(Get.find()));
    Get.lazyPut(() => ConverterLogic(
      fetchConverterData: Get.find(),
      saveSettings: Get.find(),
      subscribeSettings: Get.find(),
    ));
  }
}
