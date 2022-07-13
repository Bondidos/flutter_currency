import 'package:flutter_currency/domain/entities/rate_settings.dart';
import 'package:flutter_currency/domain/repositories/currency_settings_repository.dart';
import 'package:flutter_currency/domain/use_cases/use_case.dart';

class SaveCurrencySettingsUseCase
    extends UseCase<CurrencySettingsRepository, List<RateSettings>> {
  SaveCurrencySettingsUseCase({required CurrencySettingsRepository repository})
      : super(repository);

  @override
  void call({List<RateSettings>? params}) =>
      repository.saveSettings(params!);
}
