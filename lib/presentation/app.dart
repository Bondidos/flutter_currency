import 'package:flutter/material.dart';
import 'package:flutter_currency/presentation/controllers/home/binding.dart';
import 'package:flutter_currency/presentation/controllers/settings/binding.dart';
import 'package:flutter_currency/presentation/pages/home/view.dart';
import 'package:flutter_currency/presentation/pages/settings/view.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: HomePage.id,
      getPages: [
        GetPage(
          name: HomePage.id,
          page: () => const HomePage(),
          binding: HomeBinding(),
        ),
        GetPage(
          name: SettingsPage.id,
          page: () => const SettingsPage(),
          binding: SettingsBinding(),
        )
      ],
    );
  }
}
