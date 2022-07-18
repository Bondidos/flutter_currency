import 'package:flutter_currency/domain/entities/converter_settings.dart';
import 'package:flutter_currency/domain/entities/currency.dart';

abstract class ConverterRepository{
  List<ConverterData> fetchConverterData();
  Stream<ConverterSettings> subscribeConverterSettings();
  void saveConverterSettings(ConverterSettings settings);
}