import 'package:flutter_currency/data/repositories/currency_repo_impl.dart';
import 'package:flutter_currency/domain/usecases/fetch_currency_rates_use_case.dart';
import 'package:get/get.dart';

import 'logic.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FetchCurrencyRatesUseCase(repository: Get.find<CurrencyRepoImpl>()));
    Get.lazyPut(() => HomeLogic(fetchRates: Get.find()));
  }
}
