import 'package:flutter_currency/domain/entities/rate_settings.dart';
import 'package:flutter_currency/domain/use_cases/fetch_settings_use_case.dart';
import 'package:flutter_currency/domain/use_cases/save_currency_settings_use_case.dart';
import 'package:get/get.dart';

class SettingsLogic extends GetxController {
  final FetchSettingsUseCase fetchSettingsUseCase;
  final SaveCurrencySettingsUseCase saveCurrencySettingsUseCase;
  var settings = <RateSettings>[].obs;

  SettingsLogic({
    required this.fetchSettingsUseCase,
    required this.saveCurrencySettingsUseCase,
  });

  @override
  void onInit() {
    _fetchSettings();
    _saveSettingsOnChange();
    super.onInit();
  }

  void _fetchSettings() {
    var settingsData = fetchSettingsUseCase();
    settings.assignAll(settingsData);
  }
  void _saveSettingsOnChange(){
    ever<List<RateSettings>>(settings, (list) => _saveSettings(list));
  }

  void _saveSettings(List<RateSettings> list) {
    if (list.isNotEmpty) saveCurrencySettingsUseCase(list);
    return;
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

  void saveAndReturnHome() => Get.back();
}
