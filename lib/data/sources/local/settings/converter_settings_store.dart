import 'package:flutter_currency/domain/entities/converter_settings.dart';

abstract class ConverterSettingsStore{
  Stream<ConverterSettings> subscribe();
  void save(ConverterSettings settings);
}