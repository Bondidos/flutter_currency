import 'package:flutter/material.dart';
import 'package:flutter_currency/presentation/controllers/converter/logic.dart';
import 'package:get/get.dart';

class ExchangeResult extends GetView<CalculatorLogic> {
  const ExchangeResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // CalculatingResult? result = controller.exchangeResult.value;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Obx(() => Text('${controller.exchangeResult.value?.fromAmount} ${controller.exchangeResult.value?.fromAbr} =')),
                Obx(() => Text('${controller.exchangeResult.value?.toAmount} ${controller.exchangeResult.value?.toAbr}')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
