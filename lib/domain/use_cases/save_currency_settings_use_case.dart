import 'package:flutter_currency/domain/entities/rate_settings.dart';
import 'package:flutter_currency/domain/repositories/currency_settings_repository.dart';

class SaveCurrencySettingsUseCase {
  final CurrencySettingsRepository repository;

  SaveCurrencySettingsUseCase({required this.repository});
  void call(List<RateSettings>settings) => repository.saveSettings(settings);
}
