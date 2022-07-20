import 'package:flutter_currency/presentation/pages/settings/view.dart';
import 'package:get/get.dart';

class BottomNavigationLogic extends GetxController{
  var pageIndex = 0.obs;
  void navigateTo(int index) => pageIndex.value = index;
  void navigateSettings() => Get.toNamed(SettingsPage.id);
}