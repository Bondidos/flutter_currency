import 'package:flutter_currency/domain/usecases/fetch_currency_rates_use_case.dart';
import 'package:flutter_currency/domain/usecases/save_currency_settings_use_case.dart';
import 'package:get/get.dart';

import 'logic.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SaveCurrencySettingsUseCase(repository: Get.find()));
    Get.lazyPut(() => FetchCurrencyRatesUseCase(repository: Get.find()));
    Get.lazyPut(
      () => SettingsLogic(
        saveSettings: Get.find(),
        fetchSettings: Get.find(),
      ),
    );
  }
}
