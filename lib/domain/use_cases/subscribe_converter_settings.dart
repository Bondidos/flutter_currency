import 'package:flutter_currency/domain/entities/converter_settings.dart';
import 'package:flutter_currency/domain/repositories/converter_repository.dart';
import 'package:flutter_currency/domain/use_cases/use_case.dart';

class SubscribeConverterSettings extends UseCase<ConverterRepository, void> {
  SubscribeConverterSettings({required ConverterRepository repository})
      : super(repository);

  @override
  Stream<ConverterSettings> call({void params}) =>
      repository.subscribeConverterSettings();
}
