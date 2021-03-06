import 'package:flutter_currency/app/extensions/common.dart';
import 'package:flutter_currency/data/models/currency_api.dart';
import 'package:flutter_currency/data/models/rate_api.dart';
import 'package:flutter_currency/data/models/rate_model.dart';
import 'package:flutter_currency/data/remote/remote_source_impl/extensions/currency_repo_ext.dart';
import 'package:flutter_currency/data/sources/local/settings/date_settings.dart';
import 'package:flutter_currency/data/sources/remote/currency_remote_source.dart';
import 'package:flutter_currency/data/sources/remote/services/currency_service.dart';
import 'package:flutter_currency/domain/entities/rate.dart';
import 'package:flutter_currency/domain/entities/rates_on_date.dart';

class CurrencyRemoteSourceImpl implements CurrencyRemoteSource {
  final DateSettings dateSettings;
  final CurrencyService currencyService;

  CurrencyRemoteSourceImpl({
    required this.currencyService,
    required this.dateSettings,
  });

  @override
  Future<RatesOnDate> fetchRates() async {
    final List<RateApi> todayResponse = await currencyService.fetchTodayRates();
    final List<RateApi> alternativeResponse = await _fetchAlternativeRates();
    return _createResultList(
      alternativeRates: alternativeResponse,
      todayRates: todayResponse,
    );
  }

  Future<List<RateApi>> _fetchAlternativeRates() async {
    final List<RateApi> tomorrowResponse =
        await currencyService.fetchTomorrowRates();
    if (tomorrowResponse.isNotEmpty) return tomorrowResponse;
    final List<RateApi> yesterdayResponse =
        await currencyService.fetchYesterdayRates();
    if (yesterdayResponse.isNotEmpty) return yesterdayResponse;
    return currencyService.fetchLastKnownRates();
  }

  RatesOnDate _createResultList({
    required List<RateApi> todayRates,
    required List<RateApi> alternativeRates,
  }) {
    final coreList = (todayRates.isEmpty) ? alternativeRates : todayRates;
    final rates = List<Rate>.generate(
      coreList.length,
      (index) => RateModel.fromActualAndAlternative(
        current: coreList[index],
        alternative: alternativeRates[index],
      ),
    );
    return RatesOnDate(
      rates: rates,
      currentDate: dateSettings.currentDate.asString(),
      alternativeDate: dateSettings.alternativeDate.asString(),
      isTomorrowRatesExists: dateSettings.isTomorrowRatesExists,
    );
  }

  @override
  Future<List<CurrencyApi>> fetchCurrencyInfo() async {
    List<CurrencyApi> info = await currencyService.fetchCurrencyInfo();
    return info.filterOld();
  }
}
