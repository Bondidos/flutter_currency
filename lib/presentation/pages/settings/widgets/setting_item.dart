import 'package:flutter/material.dart';
import 'package:flutter_currency/domain/entities/rate_settings.dart';
import 'package:flutter_currency/presentation/controllers/settings/logic.dart';
import 'package:get/get.dart';

class SettingItem extends StatelessWidget {
  final RateSettings setting;

  const SettingItem({Key? key, required this.setting}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SettingsLogic controller = Get.find();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(setting.curAbbr),
                Text("${setting.curScale} ${setting.curName}"),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Switch(
              onChanged: (bool value) =>
                  controller.changeVisibility(setting.id),
              value: setting.isShow,
            ),
          ),
          const Expanded(
            flex: 1,
            child: Icon(Icons.drag_handle),
          ),
        ],
      ),
    );
  }
}