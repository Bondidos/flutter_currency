import 'package:flutter_currency/domain/usecases/fetch_currency_rates_use_case.dart';
import 'package:flutter_currency/presentation/controllers/home/state.dart';
import 'package:get/get.dart';

class HomeLogic extends GetxController with StateMixin<HomeState> {
  final FetchCurrencyRatesUseCase fetchRates;
  HomeLogic({required this.fetchRates});

  @override
  void onInit() async {
    var data = await fetchRates();
    change(HomeState(rates: data),status: RxStatus.success());
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  @override
  void dispose() {

  }
}
