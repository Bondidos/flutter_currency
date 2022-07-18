import 'package:hive/hive.dart';

part 'adapters/converter_settings.g.dart';

@HiveType(typeId: 4)
class ConverterSettings {
  @HiveField(0)
  final int fromCurrencyId;
  @HiveField(1)
  final int toCurrencyId;

  ConverterSettings({
    required this.fromCurrencyId,
    required this.toCurrencyId,
  });
}
