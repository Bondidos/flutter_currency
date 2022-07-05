import 'package:flutter_currency/domain/usecases/fetch_currency_rates_use_case.dart';
import 'package:get/get.dart';

import 'logic.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FetchCurrencyRatesUseCase(repository: Get.find()));
    Get.lazyPut(() => HomeLogic(fetchRates: Get.find()));
  }
}
