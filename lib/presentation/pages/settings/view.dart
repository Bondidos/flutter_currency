import 'package:flutter/material.dart';
import 'package:flutter_currency/domain/entities/rate_settings.dart';
import 'package:flutter_currency/presentation/controllers/settings/logic.dart';
import 'package:flutter_currency/presentation/pages/settings/widgets/setting_item.dart';
import 'package:get/get.dart';

class SettingsPage extends GetView<SettingsLogic> {
  const SettingsPage({Key? key}) : super(key: key);

  static const id = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CurrencySettings"),
        actions: [
          IconButton(
            onPressed: () {
              controller.saveAndReturnHome();
            },
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: Obx(
        () {
          return ReorderableListView(
            children: _generateList(controller.settings),
            onReorder: (int oldIndex, int newIndex) {
              controller.setNewIndexes(oldIndex, newIndex);
            },
          );
        },
      ),
    );
  }
}

_generateList(List<RateSettings> list) {
  return List.generate(
    list.length,
    (index) => SettingItem(
      setting: list[index],
      key: Key('$index'),
    ),
  );
}