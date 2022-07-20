import 'package:flutter_currency/domain/use_cases/fetch_settings_use_case.dart';
import 'package:flutter_currency/domain/use_cases/save_currency_settings_use_case.dart';
import 'package:get/get.dart';

import 'logic.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FetchSettingsUseCase(repository: Get.find()));
    Get.lazyPut(() => SaveCurrencySettingsUseCase(repository: Get.find()));
    Get.lazyPut(() => SettingsLogic(
          saveCurrencySettingsUseCase: Get.find(),
          fetchSettingsUseCase: Get.find(),
        ));
  }
}
