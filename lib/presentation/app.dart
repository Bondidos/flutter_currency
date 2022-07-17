import 'package:flutter/material.dart';
import 'package:flutter_currency/presentation/controllers/home/binding.dart';
import 'package:flutter_currency/presentation/controllers/settings/binding.dart';
import 'package:flutter_currency/presentation/pages/converter/view.dart';
import 'package:flutter_currency/presentation/pages/home/view.dart';
import 'package:flutter_currency/presentation/pages/settings/view.dart';
import 'package:get/get.dart';

import 'controllers/converter/binding.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white).copyWith(
          primary: Colors.white,
          onPrimary: Colors.black,
        ),
        textTheme: const TextTheme(
          bodyText1: TextStyle(),
          bodyText2: TextStyle(),
        ).apply(
          bodyColor: Colors.black,
          displayColor: Colors.black,
          decorationColor: Colors.black,
        ),
      ),
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
        ),
        GetPage(
          name: ConverterPage.id,
          page: () => const ConverterPage(),
          binding: CalculatorBinding(),
        )
      ],
    );
  }
}
