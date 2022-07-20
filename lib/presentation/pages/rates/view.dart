import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_currency/presentation/pages/rates/widgets/date_panel.dart';
import 'package:flutter_currency/presentation/pages/rates/widgets/rate_item.dart';
import 'package:flutter_currency/presentation/controllers/rates/logic.dart';

class RatesPage extends GetView<RatesLogic> {
  const RatesPage({Key? key}) : super(key: key);
  static const id = 'Rates';

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: controller.fetchRates,
      child: controller.obx(
        (state) {
          if (state == null) return const SizedBox.shrink();
          return Column(
            children: [
              DatePanel(
                currentDate: state.currentDate,
                alternativeDate: state.alternativeDate,
                isTomorrowRatesExists: state.isTomorrowRatesExists,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: state.rates.length,
                  itemBuilder: (context, index) {
                    return RateItem(
                      rate: state.rates[index],
                      isTomorrowRatesExist: state.isTomorrowRatesExists,
                    );
                  },
                ),
              ),
            ],
          );
        },
        onError: (message) => GetSnackBar(
          message: message,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 1),
        ),
      ),
    );
  }
}
