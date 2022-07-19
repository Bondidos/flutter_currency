import 'package:flutter/material.dart';
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: buildAppBar(context),
        body: controller.obx(
          (state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    buildCurrencyPickers(state),
                    const ExchangeAmount(),
                    const ExchangeResult(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: const Center(child: Text("Converter")),
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


