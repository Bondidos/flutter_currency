import 'dart:async';

import 'package:flutter_currency/domain/entities/rate_settings.dart';
import 'package:flutter_currency/domain/use_cases/fetch_settings_use_case.dart';
import 'package:flutter_currency/domain/use_cases/save_currency_settings_use_case.dart';
import 'package:get/get.dart';

class SettingsLogic extends GetxController {
  final FetchSettings fetchSettings;
  final SaveCurrencySettingsUseCase saveCurrencySettingsUseCase;
  var settings = <RateSettings>[].obs;

  SettingsLogic({
    required this.fetchSettings,
    required this.saveCurrencySettingsUseCase,
  });

  @override
  void onInit() {
    _fetchSettings();
    super.onInit();
  }

  StreamSubscription<List<RateSettings>>? rateSettingsStream;

  void _fetchSettings() {
    rateSettingsStream = fetchSettings().listen(
      (list) {
        if (settings.isEmpty) settings.assignAll(list);
      },
    );
  }

  void _saveSettings(List<RateSettings> list) =>
      saveCurrencySettingsUseCase(params: list);

  void setNewIndexes(int id, int oldIndex, int newIndex) {
    //todo implement method
  }

  void changeVisibility(int id) {
    List<RateSettings> newList = List.generate(
      settings.length,
      (index) => settings[index].id != id
          ? settings[index]
          : settings[index].changeVisibility(),
    );
    settings.assignAll(newList);
  }

  void saveAndReturnHome() {
    _saveSettings(settings);
    Get.back();
  }

  @override
  void onClose() async {
    rateSettingsStream?.cancel();
    super.onClose();
  }
}
