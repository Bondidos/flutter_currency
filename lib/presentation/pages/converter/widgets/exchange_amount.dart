import 'package:flutter/material.dart';
import 'package:flutter_currency/presentation/controllers/converter/logic.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class ExchangeAmount extends GetView<CalculatorLogic> {
  const ExchangeAmount({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        initialValue: controller.amountBuffer.value.toString(),
        decoration: buildInputDecoration(),
        keyboardType: TextInputType.number,
        maxLength: 12,
        cursorColor: Colors.blueAccent,
        onChanged: controller.onTextChange,
      ),
    );
  }

  InputDecoration buildInputDecoration() {
    return InputDecoration(
      floatingLabelBehavior: FloatingLabelBehavior.always,
      label: const Text(
        'Amount',
        style: TextStyle(color: Colors.blueAccent),
      ),
      focusedBorder: buildOutlineInputBorder(),
      enabledBorder: buildOutlineInputBorder(),
    );
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return const OutlineInputBorder(
      borderSide: BorderSide(
        width: 1.5,
        color: Colors.blueAccent,
      ),
    );
  }
}
