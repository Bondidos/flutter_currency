import 'package:flutter/material.dart';
import 'package:flutter_currency/domain/entities/rate.dart';
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

class DatePanel extends StatelessWidget {
  const DatePanel({
    Key? key,
    required this.currentDate,
    required this.alternativeDate,
    required this.isTomorrowRatesExists,
  }) : super(key: key);
  final String currentDate;
  final String alternativeDate;
  final bool isTomorrowRatesExists;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          const Expanded(
            flex: 2,
            child: SizedBox.shrink(),
          ),
          Expanded(
            flex: 1,
            child: Text(isTomorrowRatesExists ? currentDate : alternativeDate),
          ),
          Expanded(
            flex: 1,
            child: Text(isTomorrowRatesExists ? alternativeDate : currentDate),
          )
        ],
      ),
    );
  }
}

class RateItem extends StatelessWidget {
  const RateItem({
    Key? key,
    required this.rate,
    required this.isTomorrowRatesExist,
  }) : super(key: key);
  final Rate rate;
  final bool isTomorrowRatesExist;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(rate.curAbbr),
                Text("${rate.curScale} ${rate.curName}"),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(isTomorrowRatesExist
                    ? rate.actualCurRate.toString()
                    : rate.alternativeCurRate.toString()),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(isTomorrowRatesExist
                    ? rate.alternativeCurRate.toString()
                    : rate.actualCurRate.toString()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

extension NullCheck on String? {
  String ifNullThenEmpty() => this ?? "";
}

requireNotNull(Object? o) => o ?? (throw NullThrownError());
