import 'package:flutter/material.dart';
import 'package:flutter_currency/presentation/controllers/bottom_navigation/logic.dart';
import 'package:flutter_currency/presentation/pages/converter/view.dart';
import 'package:flutter_currency/presentation/pages/rates/view.dart';
import 'package:flutter_currency/presentation/pages/trends/view.dart';
import 'package:get/get.dart';

const List<Widget> _pages = [
  RatesPage(),
  ConverterPage(),
  TrendsPage(),
];

const _navItems = [
  BottomNavigationBarItem(
    label: RatesPage.id,
    icon: Icon(Icons.home),
  ),
  BottomNavigationBarItem(
    label: ConverterPage.id,
    icon: Icon(Icons.currency_exchange),
  ),
];

const _labels = [
  RatesPage.id,
  ConverterPage.id,
];

class BottomNavigationPage extends GetView<BottomNavigationLogic> {
  const BottomNavigationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          appBar: buildAppBar(context, controller.pageIndex.value),
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.white,
            backgroundColor: Colors.blueAccent,
            currentIndex: controller.pageIndex.value,
            items: _navItems,
            onTap: controller.navigateTo,
          ),
          body: _pages[controller.pageIndex.value],
        );
      },
    );
  }

  AppBar buildAppBar(BuildContext context, int index) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Center(child: Text(_labels[index])),
      backgroundColor: Theme.of(context).colorScheme.primary,
      elevation: 0,
      actions: [
        IconButton(
          onPressed: controller.navigateSettings,
          icon: const Icon(Icons.settings),
        )
      ],
    );
  }
}
