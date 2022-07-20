import 'package:get/get.dart';

import 'logic.dart';

class TrendsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TrendsLogic());
  }
}
