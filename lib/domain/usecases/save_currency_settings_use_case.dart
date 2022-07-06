import 'package:flutter_currency/domain/repositories/currency_settings_repository.dart';

class SaveCurrencySettingsUseCase {
  final CurrencySettingsRepository repository;

  SaveCurrencySettingsUseCase({required this.repository});
  void call(Map<String, bool> settings) => repository.saveSettings(settings);
}
