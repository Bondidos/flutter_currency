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

    return tomorrowResponse.isNotEmpty
        ? tomorrowResponse
        : await currencyService.fetchYesterdayRates();
  }

  RatesOnDate _createResultList({
    required List<RateApi> todayRates,
    required List<RateApi> alternativeRates,
  }) {
    final core = (todayRates.isEmpty) ? alternativeRates : todayRates;
    final rates = List<Rate>.generate(
      core.length,
      (index) => RateModel.fromActualAndAlternative(
        current: core[index],
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
}
