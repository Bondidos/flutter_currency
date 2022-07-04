import 'package:flutter/material.dart';
import 'package:flutter_currency/presentation/app.dart';
import 'package:get/get.dart';

import 'app/di/dependency_creator.dart';
import 'data/sources/local/date_storage/provider.dart';

void main() async {
  DependencyCreator.init();
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  runApp(const App());
}

initServices() async{
  await Get.putAsync(() => DataStorageImpl().init());
}