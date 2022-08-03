import 'package:flutter/material.dart';
import 'package:flutter_currency/presentation/controllers/trends/logic.dart';
import 'package:get/get.dart';

import 'widgets/month_trends.dart';

class TrendsPage extends GetView<TrendsLogic> {
  const TrendsPage({Key? key}) : super(key: key);
  static const id = '/trends';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: Get.width,
          width: Get.width,
          child: Padding(
            padding: const EdgeInsets.all(35.0),
            child: GetBuilder<TrendsLogic>(builder: (logic) {
              return controller.obx((state) {
                if (state == null) return const SizedBox.shrink();
                return MonthTrends(state: state);
              });
            }),
          ),
        ),
      ),
    );
  }
}
