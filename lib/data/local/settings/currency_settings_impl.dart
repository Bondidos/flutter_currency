import 'package:flutter_currency/data/local/settings/extensions/currency_settings_ext.dart';
import 'package:flutter_currency/data/sources/local/settings/currency_settings.dart';
import 'package:flutter_currency/domain/entities/rate.dart';
import 'package:flutter_currency/domain/entities/rate_settings.dart';
import 'package:hive/hive.dart';

const currencySettingsKey = 'currencySettings';

class CurrencySettingsImpl implements CurrencySettings {
  final Box<List> currencySettings;

  CurrencySettingsImpl({
    required this.currencySettings,
  });

  @override
  void createSettings(List<Rate> rates) =>
      currencySettings.put(currencySettingsKey, rates.createSettings());

  @override
  List<RateSettings> fetchSettings() {
    List list = currencySettings.get(currencySettingsKey) ?? [];
    return list.cast<RateSettings>();
  }

  @override
  void updateSettings(List<RateSettings> settings) {
    currencySettings.clear();
    currencySettings.put(currencySettingsKey, settings);
  }
}
