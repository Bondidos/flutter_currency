import 'package:flutter_currency/data/local/settings/extensions/date_settings_ext.dart';
import 'package:flutter_currency/data/sources/local/settings/date_settings.dart';
import 'package:flutter_currency/data/sources/remote/currency_remote_source.dart';
import 'package:flutter_currency/domain/entities/rate.dart';
import 'package:flutter_currency/domain/entities/rates_on_date.dart';
import 'package:flutter_currency/domain/repositories/currency_repository.dart';
import 'package:get/get.dart';

class CurrencyRepoImpl extends GetxService implements CurrencyRepository {
  final CurrencyRemoteSource currencyRemoteSource;
  final DateSettings dateSettings;

  CurrencyRepoImpl({
    required this.currencyRemoteSource,
    required this.dateSettings,
  });

  @override
  Future<RatesOnDate> fetchRates() async {
    final List<Rate> rates = await currencyRemoteSource.fetchRates();

    return RatesOnDate(
      rates: rates,
      currentDate: dateSettings.currentDate.asString(),
      alternativeDate: dateSettings.alternativeDate.asString(),
      isTomorrowRatesExists: dateSettings.isTomorrowRatesExists,
    );
  }
}
