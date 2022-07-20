import 'package:flutter/material.dart';
import 'package:flutter_currency/presentation/controllers/converter/calculation_result.dart';
import 'package:flutter_currency/presentation/controllers/converter/logic.dart';
import 'package:get/get.dart';

class ExchangeResult extends GetView<ConverterLogic> {
  const ExchangeResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Rx<CalculationResult>? result = controller.exchangeResult;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height/3,
        child: Card(
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '${result?.value.fromAmountAndAbr}',
                    style: TextStyle(
                      fontSize: Theme.of(context).textTheme.headline6?.fontSize,
                    ),
                  ),
                  Text(
                    '${result?.value.toAmountAndAbr}',
                    style: TextStyle(
                      fontSize: Theme.of(context).textTheme.headline5?.fontSize,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Rate: ${result?.value.rate}',
                    style: TextStyle(
                      fontSize: Theme.of(context).textTheme.headline6?.fontSize,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
