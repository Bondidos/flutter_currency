import 'package:flutter/material.dart';
import 'package:flutter_currency/presentation/pages/home/widgets/date_panel.dart';
import 'package:flutter_currency/presentation/pages/home/widgets/rate_item.dart';
import 'package:get/get.dart';

import 'package:flutter_currency/presentation/controllers/home/logic.dart';

class HomePage extends GetView<HomeLogic> {
  const HomePage({Key? key}) : super(key: key);
  static const id = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Currencies"),
        actions: [
          IconButton(
              onPressed: controller.navigateSettings,
              icon: const Icon(Icons.settings),
          )
        ],
      ),
      body: controller.obx(
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
