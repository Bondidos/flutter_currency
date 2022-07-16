import 'package:get/get.dart';

import '../../pages/calculator/logic.dart';

class CalculatorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CalculatorLogic());
  }
}
