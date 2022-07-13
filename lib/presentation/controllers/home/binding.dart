import 'package:flutter_currency/domain/use_cases/fetch_currency_rates_use_case.dart';
import 'package:get/get.dart';

import 'logic.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FetchCurrencyRates(repository: Get.find()));
    Get.lazyPut(() => HomeLogic(fetchRatesUseCase: Get.find()));
  }
}
