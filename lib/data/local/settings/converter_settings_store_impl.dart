import 'package:flutter_currency/app/constants.dart';
import 'package:flutter_currency/data/sources/local/settings/converter_settings_store.dart';
import 'package:flutter_currency/domain/entities/converter_settings.dart';
import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';

const defaultToCurrency = usd;
const defaultFromCurrency = byn;
const converterSettingsKey = 'converterSettingsKey';

class ConverterSettingsStoreImpl implements ConverterSettingsStore {
  final Box<ConverterSettings> store;

  BehaviorSubject<ConverterSettings> subject = BehaviorSubject();

  ConverterSettingsStoreImpl({required this.store}) {
    _initStreamFirstValue();
  }

  ConverterSettings? get _settings => store.get(converterSettingsKey);

  @override
  void save(ConverterSettings settings) async {
    await store.put(converterSettingsKey, settings);
    subject.add(_settings!);
  }

  @override
  Stream<ConverterSettings> subscribe() => subject.stream;

  void _initStreamFirstValue() async {
    if (_settings == null) await _createDefaultSettings();
    subject.add(_settings!);
  }

  Future<void> _createDefaultSettings() async {
    final defaultSettings = ConverterSettings(
      fromCurrencyId: defaultFromCurrency,
      toCurrencyId: defaultToCurrency,
    );
    await store.put(converterSettingsKey, defaultSettings);
  }
}
