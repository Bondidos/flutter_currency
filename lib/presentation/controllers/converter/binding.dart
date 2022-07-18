import 'package:flutter_currency/domain/use_cases/fetch_converter_data.dart';
import 'package:flutter_currency/domain/use_cases/save_converter_settings.dart';
import 'package:flutter_currency/domain/use_cases/subscribe_converter_settings.dart';
import 'package:get/get.dart';

import 'logic.dart';

class CalculatorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FetchConverterData(repository: Get.find()));
    Get.lazyPut(() => SaveConverterSettings(Get.find()));
    Get.lazyPut(() => SubscribeConverterSettings(Get.find()));
    Get.lazyPut(() => CalculatorLogic(
          fetchConverterData: Get.find(),
          saveSettings: Get.find(),
          subscribeSettings: Get.find(),
        ));
  }
}
