import 'dart:async';

import 'package:flutter_currency/domain/entities/rates_on_date.dart';
import 'package:flutter_currency/domain/use_cases/fetch_currency_rates_use_case.dart';
import 'package:flutter_currency/presentation/controllers/home/state.dart';
import 'package:flutter_currency/presentation/pages/settings/view.dart';
import 'package:get/get.dart';

class HomeLogic extends GetxController with StateMixin<HomeState> {
  final FetchCurrencyRates fetchRatesUseCase;

  HomeLogic({
    required this.fetchRatesUseCase,
  });

  /**
   * stream should to create here and pass it sink to the repository
   * by usecase, after it close here by dispose method
   */

  @override
  void onInit() async {
    fetchRates();
    super.onInit();
  }

  StreamSubscription<RatesOnDate?>? ratesOnDateStream;

  Future<void> fetchRates() async {
    change(null, status: RxStatus.loading());
    ratesOnDateStream = fetchRatesUseCase().listen(
      (event) {
        if (event == null) return;
        change(
          HomeState.fromRatesOnDate(event),
          status: RxStatus.success(),
        );
      },
      onError: (e) {
        change(null, status: RxStatus.error(e.toString()));
      },
    );
    /*try {} on FetchDataException {
      change(null, status: RxStatus.error("No Internet connection"));
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }*/
  }

  void navigateSettings() => Get.toNamed(SettingsPage.id);

  @override
  void onClose() {
    ratesOnDateStream = null;
    super.onClose();
  }
}
