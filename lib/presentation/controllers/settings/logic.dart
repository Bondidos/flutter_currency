import 'package:flutter_currency/domain/usecases/fetch_settings_use_case.dart';
import 'package:flutter_currency/domain/usecases/save_currency_settings_use_case.dart';
import 'package:flutter_currency/presentation/controllers/settings/state.dart';
import 'package:get/get.dart';

class SettingsLogic extends GetxController with StateMixin<SettingsState> {
  final FetchSettingsUseCase fetchSettings;
  final SaveCurrencySettingsUseCase saveSettings;

  SettingsLogic({required this.fetchSettings, required this.saveSettings});
}
