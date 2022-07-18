import 'package:flutter_currency/domain/entities/converter_settings.dart';
import 'package:flutter_currency/domain/repositories/converter_repository.dart';
import 'package:flutter_currency/domain/use_cases/use_case.dart';

class SaveConverterSettings extends UseCase<ConverterRepository, ConverterSettings>{
  SaveConverterSettings(super.repository);

  @override
  void call({ConverterSettings? params}) => repository.saveConverterSettings(params!);

}