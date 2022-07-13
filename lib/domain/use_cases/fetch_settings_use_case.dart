import 'package:flutter_currency/domain/entities/rate_settings.dart';
import 'package:flutter_currency/domain/repositories/currency_settings_repository.dart';
import 'package:flutter_currency/domain/use_cases/use_case.dart';

class FetchSettings extends UseCase<CurrencySettingsRepository, void> {
  FetchSettings({required CurrencySettingsRepository repository})
      : super(repository);

  @override
  Stream<List<RateSettings>> call({params}) => repository.fetchSettings();
}
