import 'dart:async';

import 'package:flutter_currency/data/remote/source/exceptions.dart';
import 'package:flutter_currency/domain/entities/rates_on_date.dart';
import 'package:flutter_currency/domain/use_cases/fetch_currency_rates_use_case.dart';
import 'package:flutter_currency/presentation/controllers/home/state.dart';
import 'package:flutter_currency/presentation/pages/settings/view.dart';
import 'package:get/get.dart';

class HomeLogic extends GetxController with StateMixin<HomeState> {
  final FetchCurrencyRatesUseCase fetchRatesUseCase;

  HomeLogic({required this.fetchRatesUseCase});

  @override
  void onInit() async {
    fetchRates();
    super.onInit();
  }

  late StreamSubscription<RatesOnDate?> str;

  Future<void> fetchRates() async {
    change(null, status: RxStatus.loading());
      str = fetchRatesUseCase().listen((event) {
        if (event == null) return;
        change(
          HomeState.fromRatesOnDate(event),
          status: RxStatus.success(),
        );
      },
        // todo error handling
      onError: (e) {
        print(e.toString());
        change(null, status: RxStatus.error(e.toString()));
      },

      );
    try {

    } on FetchDataException {
      change(null, status: RxStatus.error("No Internet connection"));
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  navigateSettings() => Get.toNamed(SettingsPage.id);
}
