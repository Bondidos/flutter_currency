import 'package:flutter/material.dart';
import 'package:flutter_currency/presentation/controllers/converter/logic.dart';
import 'package:flutter_currency/presentation/controllers/converter/state.dart';
import 'package:flutter_currency/presentation/pages/converter/widgets/exchange_amount.dart';
import 'package:flutter_currency/presentation/pages/converter/widgets/currency_picker.dart';
import 'package:flutter_currency/presentation/pages/converter/widgets/result.dart';
import 'package:flutter_currency/presentation/pages/trends/view.dart';
import 'package:get/get.dart';

class ConverterPage extends GetView<ConverterLogic> {
  const ConverterPage({Key? key}) : super(key: key);
  static const id = 'converter';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: controller.obx(
        (state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  buildCurrencyPickers(state),
                  const ExchangeAmount(),
                  const ExchangeResult(),
                  TextButton(
                    child: const Text(
                      'Show trends',
                      style: TextStyle(color: Colors.blueAccent,fontSize: 20),
                    ),
                    onPressed: () => Get.toNamed(TrendsPage.id),
                  )
                ],
              ),
            ),
          );
        },
      ),
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
