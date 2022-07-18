import 'package:flutter/material.dart';
import 'package:flutter_currency/presentation/app_drawer/view.dart';
import 'package:flutter_currency/presentation/controllers/converter/logic.dart';
import 'package:flutter_currency/presentation/controllers/converter/state.dart';
import 'package:flutter_currency/presentation/pages/converter/widgets/exchange_amount.dart';
import 'package:flutter_currency/presentation/pages/converter/widgets/currency_picker.dart';
import 'package:flutter_currency/presentation/pages/converter/widgets/result.dart';
import 'package:get/get.dart';

class ConverterPage extends GetView<CalculatorLogic> {
  const ConverterPage({Key? key}) : super(key: key);
  static const id = '/converter';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      drawer: const AppDrawer(),
      body: controller.obx(
        (state) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                buildCurrencyPickers(state),
                const ExchangeAmount(),
                const ExchangeResult(),
              ],
            ),
          );
        },
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      title: const Center(child: Text("Calculate")),
      backgroundColor: Theme.of(context).colorScheme.primary,
      elevation: 0,
    );
  }

  Row buildCurrencyPickers(ConverterState? state) {
    return Row(
      children: [
        Flexible(
          child: CurrencyPicker(
            data: state?.data ?? List.empty(),
            label: 'From',
            mode: ExchangeMode.from,
          ),
        ),
        Flexible(
          child: CurrencyPicker(
            data: state?.data ?? List.empty(),
            label: 'To',
            mode: ExchangeMode.to,
          ),
        ),
      ],
    );
  }
}


