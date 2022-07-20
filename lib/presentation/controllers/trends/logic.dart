import 'dart:async';

import 'package:flutter_currency/domain/entities/currency_trend.dart';
import 'package:flutter_currency/domain/use_cases/fetch_trends_month.dart';
import 'package:flutter_currency/domain/use_cases/fetch_trends_six_months.dart';
import 'package:flutter_currency/domain/use_cases/subscribe_trends.dart';
import 'package:get/get.dart';

class TrendsLogic extends GetxController{
  final SubscribeTrends subscribeTrends;
  final FetchSixMonthsTrends fetchSixMonthsTrends;
  final FetchMonthTrends fetchMonthTrends;

  TrendsLogic({
    required this.subscribeTrends,
    required this.fetchSixMonthsTrends,
    required this.fetchMonthTrends,
  });

  var trendsLength = 0.obs;

  StreamSubscription<List<CurrencyTrend>?>? subscription;

  @override
  void onInit() {
    subscription = subscribeTrends().listen((list) {
      print(list?.length);
      trendsLength.value = list?.length ?? 0;
    });
    fetchMonthTrends(params: 431);
    super.onInit();
  }

  @override
  void onClose() {
    subscription?.cancel();
    super.onClose();
  }

}
