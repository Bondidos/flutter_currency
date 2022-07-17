import 'package:flutter/material.dart';
import 'package:flutter_currency/presentation/app_drawer/logic.dart';
import 'package:get/get.dart';

class AppDrawer extends GetView<MenuLogic> {
  const AppDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration:
            BoxDecoration(color: Theme.of(context).colorScheme.primary),
            child: const Text('Menu'),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
              controller.navigateToHome();
            },
          ),
          ListTile(
            title: const Text('Calculate rates'),
            onTap: () {
              Navigator.pop(context);
              controller.navigateToCalculator();
            },
          ),
          ListTile(
            title: const Text('Show trends'),
            onTap: () {
              Navigator.pop(context);
              controller.navigateToCalculator();
            },
          ),
        ],
      ),
    );
  }
}
