import 'package:flutter/material.dart';
import 'package:flutter_currency/domain/entities/currency.dart';
import 'package:flutter_currency/presentation/controllers/converter/logic.dart';
import 'package:flutter_currency/presentation/pages/converter/widgets/menuItem_child.dart';
import 'package:get/get.dart';

enum ExchangeMode { from, to }

class CurrencyPicker extends GetView<CalculatorLogic> {
  const CurrencyPicker({
    Key? key,
    required this.data,
    required this.label,
    required this.mode,
  }) : super(key: key);
  final List<ConverterData> data;
  final ExchangeMode mode;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InputDecorator(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(2),
          enabledBorder:
              const OutlineInputBorder(borderSide: BorderSide(width: 1.3)),
          isCollapsed: true,
          labelStyle: const TextStyle(fontWeight: FontWeight.w800),
          label: Text(label),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(6.0))),
        ),
        child: PopupMenuButton(
          child: Obx(() {
            switch (mode) {
              case ExchangeMode.from:
                {
                  final currency = data.firstWhere((element) =>
                      element.id == controller.fromCurrencyId.value);
                  return buildChild(currency);
                }
              case ExchangeMode.to:
                final currency = data.firstWhere(
                    (element) => element.id == controller.toCurrencyId.value);
                return buildChild(currency);
            }
          }),
          itemBuilder: (context) => List.generate(
            data.length,
            (index) => PopupMenuItem(
              onTap: mode == ExchangeMode.from
                  ? () => controller.fromCurrency(data[index])
                  : () => controller.toCurrency(data[index]),
              child: MenuItemChild(
                converterData: data[index],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row buildChild(ConverterData converterData) {
    return Row(
      children: [
        Flexible(flex: 4, child: MenuItemChild(converterData: converterData)),
        const Flexible(child: Icon(Icons.arrow_drop_down)),
      ],
    );
  }
}