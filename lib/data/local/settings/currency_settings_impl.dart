import 'package:flutter_currency/data/local/settings/extensions/currency_settings_ext.dart';
import 'package:flutter_currency/data/sources/local/settings/currency_settings.dart';
import 'package:flutter_currency/domain/entities/rate.dart';
import 'package:get_storage/get_storage.dart';

const currencySettingsKey = 'currencySettings';

class CurrencySettingsImpl implements CurrencySettings {
  final GetStorage currencySettings;

  CurrencySettingsImpl({
    required this.currencySettings,
  });

  @override
  Future<void> createSettings(List<Rate> rates) =>
      currencySettings.write(currencySettingsKey, rates.createSettings());

  @override
  Map<String, dynamic> fetchSettings() =>
      currencySettings.read(currencySettingsKey) ?? {};
}
