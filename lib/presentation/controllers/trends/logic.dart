import 'dart:async';
import 'package:flutter_currency/domain/entities/currency_trend.dart';
import 'package:flutter_currency/domain/use_cases/fetch_trends_month.dart';
import 'package:flutter_currency/domain/use_cases/fetch_trends_six_months.dart';
import 'package:flutter_currency/domain/use_cases/subscribe_trends.dart';
import 'package:flutter_currency/presentation/controllers/trends/state.dart';
import 'package:get/get.dart';

class TrendsLogic extends GetxController with StateMixin<TrendsState> {
  final SubscribeTrends subscribeTrends;
  final FetchSixMonthsTrends fetchSixMonthsTrends;
  final FetchMonthTrends fetchMonthTrends;

  TrendsLogic({
    required this.subscribeTrends,
    required this.fetchSixMonthsTrends,
    required this.fetchMonthTrends,
  });

  StreamSubscription<List<CurrencyTrend>?>? subscription;

  @override
  void onInit() {
    change(null,status: RxStatus.loading());
    subscription = subscribeTrends().listen((trends) {
      if (trends == null || trends.isEmpty) return;
      _setState(trends);
    });
    fetchMonthTrends();
    super.onInit();
  }

  void _setState(List<CurrencyTrend> trends) {
    var maxRate = 0.0;
    var minRate = double.infinity;
    for (var element in trends) {
      if (element.rate > maxRate) maxRate = element.rate.ceil().toDouble();
      if (element.rate < minRate) minRate = element.rate.toInt().toDouble();
    }
    final state = TrendsState(
        trends: trends, maxRate: maxRate, minRate: minRate);
    change(state,status: RxStatus.success());
  }

  @override
  void onClose() {
    subscription?.cancel();
    super.onClose();
  }
}
