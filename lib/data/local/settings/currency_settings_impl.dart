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
    _addLastToStream();
  }

  void _addLastToStream() {
    final List<RateSettings> settings =
        currencySettings.get(currencySettingsKey)?.cast() ?? [];
    settingsStream.sink.add(settings);
  }

  @override
  Future<void> createSettings(List<CurrencyApi> info) async {
    await currencySettings.put(currencySettingsKey, info.createSettings());
    _addLastToStream();
  }

  @override
  Stream<List<RateSettings>> subscribeSettings() => settingsStream.stream;

  @override
  Future<void> saveSettings(List<RateSettings> settings) async {
    await currencySettings.put(currencySettingsKey, settings);
    _addLastToStream();
  }
}
