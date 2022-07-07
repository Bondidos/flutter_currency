import 'package:flutter_currency/data/repositories/extensions/currency_repo_ext.dart';
import 'package:flutter_currency/data/sources/local/database/rates_dao.dart';
import 'package:flutter_currency/data/sources/local/settings/currency_settings.dart';
import 'package:flutter_currency/data/sources/remote/currency_remote_source.dart';
import 'package:flutter_currency/domain/entities/rate.dart';
import 'package:flutter_currency/domain/entities/rate_settings.dart';
import 'package:flutter_currency/domain/entities/rates_on_date.dart';
import 'package:flutter_currency/domain/repositories/currency_repository.dart';
import 'package:get/get.dart';

class CurrencyRepoImpl extends GetxService implements CurrencyRepository {
  final CurrencyRemoteSource currencyRemoteSource;
  final CurrencySettings currencySettings;
  final RatesDao ratesDao;

  CurrencyRepoImpl({
    required this.currencyRemoteSource,
    required this.currencySettings,
    required this.ratesDao,
  });

  @override
  Future<RatesOnDate> fetchRates() async {
    final RatesOnDate ratesOnDate = await _fetchRatesFromCacheOrRemote();
    List<RateSettings> settings = currencySettings.fetchSettings();
    if(settings.isEmpty) settings = _createSettings(ratesOnDate.rates);
    return ratesOnDate.applySettings(settings);
  }

  Future<RatesOnDate> _fetchRatesFromCacheOrRemote() async {
    final RatesOnDate? ratesOnDate = ratesDao.getRates();
    if(ratesOnDate == null) return _fetchRatesThenCache();
    return ratesOnDate;
  }

  Future<RatesOnDate> _fetchRatesThenCache() async {
    final RatesOnDate ratesOnDate = await currencyRemoteSource.fetchRates();
    ratesDao.saveRatesOnDate(ratesOnDate);
    return ratesOnDate;
  }

  List<RateSettings> _createSettings(List<Rate> rates) {
    currencySettings.createSettings(rates);
    return currencySettings.fetchSettings();
  }
}

