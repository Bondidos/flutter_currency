import 'package:flutter/material.dart';
import 'package:flutter_currency/presentation/controllers/bottom_navigation/binding.dart';
import 'package:flutter_currency/presentation/controllers/settings/binding.dart';
import 'package:flutter_currency/presentation/controllers/trends/binding.dart';
import 'package:flutter_currency/presentation/pages/bottom_navigation/view.dart';
import 'package:flutter_currency/presentation/pages/settings/view.dart';
import 'package:flutter_currency/presentation/pages/trends/view.dart';
import 'package:get/get.dart';

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
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => const BottomNavigationPage(),
          binding: BottomNavigationBinding(),
        ),
        GetPage(
          name: SettingsPage.id,
          page: () => const SettingsPage(),
          binding: SettingsBinding(),
        ),
        GetPage(
          name: TrendsPage.id,
          page: () => const TrendsPage(),
          binding: TrendsBinding(),
        ),
      ],
    );
  }
}
