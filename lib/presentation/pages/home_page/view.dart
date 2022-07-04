import 'package:flutter/material.dart';
import 'package:flutter_currency/domain/entities/rate.dart';
import 'package:get/get.dart';

import '../../controllers/home/logic.dart';

class HomePage extends GetView<HomeLogic> {
  const HomePage({Key? key}) : super(key: key);
  static const id = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Currencies"),
      ),
      body: GetX(
        init: controller,
        builder: (_) {
          if (controller.state.rates.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: controller.state.rates.length,
            itemBuilder: (context, index) {
              return RateItem(rate: controller.state.rates[index]);
            },
          );
        },
      ),
    );
  }
}

class RateItem extends StatelessWidget {
  const RateItem({Key? key, required this.rate}) : super(key: key);
  final Rate rate;

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
                Text(rate.alternativeCurRate.toString()),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(rate.actualCurRate.toString()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
