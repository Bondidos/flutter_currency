import 'package:flutter_currency/data/local/settings/extensions/currency_settings_ext.dart';
import 'package:flutter_currency/data/models/currency_api.dart';
import 'package:flutter_currency/data/sources/local/settings/currency_settings.dart';
import 'package:flutter_currency/domain/entities/rate_settings.dart';
import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';

const currencySettingsKey = 'currencySettings';

class CurrencySettingsImpl implements CurrencySettings {
  final Box<List> currencySettings;
  final BehaviorSubject<List<RateSettings>> settingsStream = BehaviorSubject();

  CurrencySettingsImpl({
    required this.currencySettings,
  }) {
    settingsStream.add(_read);
    currencySettings
        .watch(key: currencySettingsKey)
        .listen((event) => settingsStream.sink.add(event.value));
  }

  @override
  void createSettings(List<CurrencyApi> info) =>
      currencySettings.put(currencySettingsKey, info.createSettings());

  @override
  Stream<List<RateSettings>> subscribeSettings() => settingsStream.stream;

  List<RateSettings> get _read =>
      currencySettings.get(currencySettingsKey)?.cast() ?? [];

  @override
  void updateSettings(List<RateSettings> settings) =>
      currencySettings.put(currencySettingsKey, settings);
}
