import 'package:flutter_currency/domain/entities/rate_settings.dart';
import 'package:flutter_currency/domain/repositories/currency_settings_repository.dart';

class FetchSettingsUseCase {
  final CurrencySettingsRepository repository;

  FetchSettingsUseCase({required this.repository});

  List<RateSettings> call(Map<String, bool> settings) =>
      repository.fetchSettings();
}
