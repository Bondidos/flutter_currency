import 'package:flutter_currency/domain/use_cases/fetch_trends_month.dart';
import 'package:flutter_currency/domain/use_cases/fetch_trends_six_months.dart';
import 'package:flutter_currency/domain/use_cases/subscribe_trends.dart';
import 'package:flutter_currency/presentation/controllers/trends/logic.dart';
import 'package:get/get.dart';

class TrendsBinding extends Bindings {
  @override
  void dependencies() {
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