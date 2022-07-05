import 'package:flutter_currency/data/remote/source/exceptions.dart';
import 'package:flutter_currency/domain/entities/rate.dart';
import 'package:flutter_currency/domain/usecases/fetch_currency_rates_use_case.dart';
import 'package:flutter_currency/presentation/controllers/home/state.dart';
import 'package:get/get.dart';

class HomeLogic extends GetxController with StateMixin<HomeState> {
  final FetchCurrencyRatesUseCase fetchRates;

  HomeLogic({required this.fetchRates});

  @override
  void onInit() async {
    change(null, status: RxStatus.loading());
    final List<Rate> data;
    try {
      data = await fetchRates();
      change(HomeState(rates: data), status: RxStatus.success());
    } on FetchDataException {
      change(null, status: RxStatus.error("No Internet connection"));
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
    super.onInit();
  }
}


