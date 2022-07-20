import 'package:flutter/material.dart';
import 'package:flutter_currency/presentation/controllers/trends/logic.dart';
import 'package:get/get.dart';

class TrendsPage extends GetView<TrendsLogic> {
  const TrendsPage({Key? key}) : super(key: key);
  static const id = 'Trends';

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      controller;
      return Center(
        child: Text(controller.trendsLength.value.toString()),
      );
    });
  }
}
