import 'package:flutter_currency/data/models/rate_api.dart';
import 'package:flutter_currency/data/models/rate_model.dart';
import 'package:flutter_currency/data/remote/remote_source_impl/extensions/currency_repo_ext.dart';
import 'package:flutter_currency/data/remote/source/api_provider.dart';
import 'package:flutter_currency/data/remote/source/apis/currency_api.dart';
import 'package:flutter_currency/data/sources/remote/currency_remote_source.dart';
import 'package:flutter_currency/domain/entities/rate.dart';

class CurrencyRemoteSourceImpl implements CurrencyRemoteSource {
  final APIProvider apiProvider;

  CurrencyRemoteSourceImpl({
    required this.apiProvider
  });

  @override
  Future<List<Rate>> fetchRates() async {
    final List<dynamic> todayResponse =
        await apiProvider.request(CurrencyRatesApi.today());
    final List<dynamic> alternativeResponse = await _fetchAlternativeRates();
    return _createResultList(
      alternativeRates: alternativeResponse.toRateApiList(),
      todayRates: todayResponse.toRateApiList(),
    );
  }

  Future<List> _fetchAlternativeRates() async {
    final List<dynamic> tomorrowResponse =
        await apiProvider.request(CurrencyRatesApi.tomorrow());

    return tomorrowResponse.isNotEmpty
        ? tomorrowResponse
        : await apiProvider.request(CurrencyRatesApi.yesterday());
  }

  List<Rate> _createResultList({
    required List<RateApi> todayRates,
    required List<RateApi> alternativeRates,
  }) {
    return List<Rate>.generate(
      todayRates.length,
      (index) => RateModel.fromActualAndAlternative(
        current: todayRates[index],
        alternative: alternativeRates[index],
      ),
    );
  }
}
