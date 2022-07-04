import 'package:flutter_currency/data/repositories/currency_repo_impl.dart';
import 'package:get/get.dart';

class DependencyCreator{
  static init(){
    Get.lazyPut(() => CurrencyRepoImpl());
  }
}