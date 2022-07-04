import 'package:flutter_currency/data/models/rate_api.dart';
import 'package:flutter_currency/data/models/rate_model.dart';
import 'package:flutter_currency/data/sources/remote/apis/currency_api.dart';
import 'package:flutter_currency/domain/entities/rate.dart';
import 'package:flutter_currency/domain/repositories/currency_repository.dart';

class CurrencyRepoImpl implements CurrencyRepository {

  @override
  Future<List<Rate>> fetchRates() async {
    final List<dynamic> todayResponse =
        await CurrencyRatesApi.today().request();
    final List<dynamic> alternativeResponse = await _fetchAlternativeRates();
    return _createResultList(todayResponse, alternativeResponse);
  }

  Future<List> _fetchAlternativeRates() async {
    final List<dynamic> tomorrowResponse =
        await CurrencyRatesApi.tomorrow().request();
    if (tomorrowResponse.isNotEmpty) return tomorrowResponse;
    final List<dynamic> yesterdayResponse =
        await CurrencyRatesApi.yesterday().request();
    return yesterdayResponse;
  }

  List<Rate> _createResultList(
    List<dynamic> todayResponse,
    List<dynamic> alternativeResponse,
  ) {
    final List<RateApi> todayRates = todayResponse.toRateList();
    final List<RateApi> alternativeRates = alternativeResponse.toRateList();
    final List<Rate> result = [];
    for (var i = 0; i < todayRates.length; i++) {
      result.add(
        RateModel.fromActualAndAlternative(
          current: todayRates[i],
          alternative: alternativeRates[i],
        ),
      );
    }
    return result;
  }
}

extension ListDynamicConverter on List<dynamic> {
  List<RateApi> toRateList() => map((e) => RateApi.fromJson(e)).toList();
}
