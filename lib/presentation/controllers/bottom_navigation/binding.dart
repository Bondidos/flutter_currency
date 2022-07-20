import 'package:flutter_currency/domain/use_cases/fetch_converter_data.dart';
import 'package:flutter_currency/domain/use_cases/fetch_currency_rates_use_case.dart';
import 'package:flutter_currency/domain/use_cases/fetch_trends_month.dart';
import 'package:flutter_currency/domain/use_cases/fetch_trends_six_months.dart';
import 'package:flutter_currency/domain/use_cases/save_converter_settings.dart';
import 'package:flutter_currency/domain/use_cases/subscribe_converter_settings.dart';
import 'package:flutter_currency/domain/use_cases/subscribe_trends.dart';
import 'package:flutter_currency/presentation/controllers/converter/logic.dart';
import 'package:flutter_currency/presentation/controllers/rates/logic.dart';
import 'package:flutter_currency/presentation/controllers/trends/logic.dart';
import 'package:get/get.dart';

import 'logic.dart';

class BottomNavigationBinding extends Bindings {
  @override
  void dependencies() {
    _bottomNavPageDependencies();
    _homeDependencies();
    _converterDependencies();
    _trendsDependencies();
  }

  void _bottomNavPageDependencies() {
    Get.lazyPut(() => BottomNavigationLogic());
  }

  void _homeDependencies() {
    Get.lazyPut(() => FetchCurrencyRates(repository: Get.find()));
    Get.lazyPut(() => RatesLogic(fetchRatesUseCase: Get.find()));
  }

  void _converterDependencies() {
    Get.lazyPut(() => FetchConverterData(repository: Get.find()));
    Get.lazyPut(() => SaveConverterSettings(Get.find()));
    Get.lazyPut(() => SubscribeConverterSettings(repository: Get.find()));
    Get.lazyPut(() => ConverterLogic(
          fetchConverterData: Get.find(),
          saveSettings: Get.find(),
          subscribeSettings: Get.find(),
        ));
  }

  void _trendsDependencies() {
    Get.lazyPut(() => SubscribeTrends(Get.find()));
    Get.lazyPut(() => FetchSixMonthsTrends(repository: Get.find()));
    Get.lazyPut(() => FetchMonthTrends(repository: Get.find()));
    Get.lazyPut(() => TrendsLogic(
          subscribeTrends: Get.find(),
          fetchSixMonthsTrends: Get.find(),
          fetchMonthTrends: Get.find(),
        ));
  }
}
