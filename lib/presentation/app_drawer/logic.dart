import 'package:flutter_currency/presentation/pages/converter/view.dart';
import 'package:flutter_currency/presentation/pages/home/view.dart';
import 'package:get/get.dart';

class MenuLogic extends GetxController {

  //todo add page indicator to show current page in drawer's list

  void navigateToCalculator() => Get.toNamed(ConverterPage.id);
  void navigateToHome() => Get.toNamed(HomePage.id);
  void navigateToTrends() => throw UnimplementedError();


}
