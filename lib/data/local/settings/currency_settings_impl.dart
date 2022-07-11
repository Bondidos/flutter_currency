import 'package:flutter_currency/data/local/settings/extensions/currency_settings_ext.dart';
import 'package:flutter_currency/data/models/currency_api.dart';
import 'package:flutter_currency/data/sources/local/settings/currency_settings.dart';
import 'package:flutter_currency/domain/entities/rate_settings.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';

const currencySettingsKey = 'currencySettings';

class CurrencySettingsImpl implements CurrencySettings {
  final Box<List> currencySettings;
  final BehaviorSubject<List<RateSettings>> settingsStream = BehaviorSubject();

  CurrencySettingsImpl({
    required this.currencySettings,
  });

  @override
  void createSettings(List<CurrencyApi> info) {
    currencySettings.put(currencySettingsKey, info.createSettings());
    settingsStream.add(_read);
  }

  @override
  Stream<List<RateSettings>> get subscribeSettings {
    return settingsStream..add(_read);
    /*List list = currencySettings.get(currencySettingsKey) ?? [];
    return list.cast<RateSettings>();*/
  }

  List<RateSettings> get _read => currencySettings.get(currencySettingsKey)?.cast() ?? [];

  @override
  void updateSettings(List<RateSettings> settings) async {
    // await currencySettings.clear();
    currencySettings.put(currencySettingsKey, settings);
    settingsStream.add(_read);
  }
}
