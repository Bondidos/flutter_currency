import 'package:flutter_currency/data/repositories/extensions/converter_repo_ext.dart';
import 'package:flutter_currency/data/sources/local/database/rates_dao.dart';
import 'package:flutter_currency/data/sources/local/settings/converter_settings_store.dart';
import 'package:flutter_currency/domain/entities/converter_settings.dart';
import 'package:flutter_currency/domain/entities/currency.dart';
import 'package:flutter_currency/domain/repositories/converter_repository.dart';

class ConverterRepositoryImpl implements ConverterRepository {
  final RatesDatastore ratesDao;
  final ConverterSettingsStore settingsStore;

  const ConverterRepositoryImpl({
    required this.ratesDao,
    required this.settingsStore,
  });

  @override
  List<ConverterData> fetchConverterData() =>
      ratesDao.fetchCurrencies().toCurrencyListAndAddBYN();

  @override
  void saveConverterSettings(ConverterSettings settings) =>
      settingsStore.save(settings);

  @override
  Stream<ConverterSettings> subscribeConverterSettings() =>
      settingsStore.subscribe();
}
