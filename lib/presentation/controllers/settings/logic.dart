import 'package:flutter_currency/domain/entities/rate_settings.dart';
import 'package:flutter_currency/domain/use_cases/fetch_settings_use_case.dart';
import 'package:flutter_currency/domain/use_cases/save_currency_settings_use_case.dart';
import 'package:get/get.dart';

class SettingsLogic extends GetxController {
  final FetchSettingsUseCase fetchSettingsUseCase;
  final SaveCurrencySettingsUseCase saveCurrencySettingsUseCase;
  List<RateSettings> settings = <RateSettings>[].obs;

  SettingsLogic({
    required this.fetchSettingsUseCase,
    required this.saveCurrencySettingsUseCase,
  });

  @override
  void onInit() {
    _fetchSettings();
    super.onInit();
  }

  void _fetchSettings() => settings = fetchSettingsUseCase();

  void setNewIndexes(int id, int oldIndex, int newIndex) {}

  void changeVisibility(int id) {
    var place = settings.indexWhere((element) => element.id == id);
    List<RateSettings> newList = List.generate(
      settings.length,
      (index) =>
          index != place ? settings[index] : settings[index].changeVisibility(),
    );
    settings.addAll(newList);
    // settings = newList;
    // update(); //todo something
  }

  void saveAndReturnHome() {
    saveCurrencySettingsUseCase(settings);
    Get.back();
  }
}
