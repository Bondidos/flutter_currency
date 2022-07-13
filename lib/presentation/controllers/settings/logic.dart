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
    // _saveSettingsOnChange();
    super.onInit();
  }

  StreamSubscription<List<RateSettings>>? rateSettingsStream;

  void _fetchSettings() {
    rateSettingsStream =
        fetchSettings().
        listen((list) =>
            settings.assignAll(list)
        );
    // var settingsData = fetchSettingsUseCase();
    // settings.assignAll(settingsData);
  }

  void _saveSettingsOnChange() {
    ever<List<RateSettings>>(settings, (list) => _saveSettings(list));
  }

  Future<void> _saveSettings(List<RateSettings> list) async{
    saveCurrencySettingsUseCase(params: list);
  }

  void setNewIndexes(int id, int oldIndex, int newIndex) {}

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
    //should to cancel subscription? cuz empty list emitting in stream
    rateSettingsStream?.cancel();
    _saveSettings(settings);
    Get.back();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
