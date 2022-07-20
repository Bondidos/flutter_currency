import 'package:flutter_currency/data/remote/source/api_request_representable.dart';
import 'package:flutter_currency/data/remote/source/apis/extensions/currency_trends_api_ext.dart';
import 'package:flutter_currency/data/remote/source/constants/api_baseurl.dart';
import 'package:flutter_currency/data/remote/source/constants/api_endpoint.dart';
import 'package:flutter_currency/data/remote/source/constants/keys.dart';

enum TrendPeriod { month, sixMonths }

class TrendsApi extends APIRequestRepresentable {
  final int currencyId;
  final TrendPeriod period;

  TrendsApi._({required this.currencyId, required this.period});

  TrendsApi.month({required int currencyId})
      : this._(currencyId: currencyId, period: TrendPeriod.month);

  TrendsApi.sixMonths({required int currencyId})
      : this._(currencyId: currencyId, period: TrendPeriod.sixMonths);

  @override
  String get baseUrl => APIBaseUrl.bnrBank;

  @override
  get body => null;

  @override
  Map<String, String>? get headers => {};

  @override
  HTTPMethod get method => HTTPMethod.get;

  @override
  String get path => APIEndPoint.trends(currencyId);

  @override
  Map<String, String>? get query => {
        Keys.startDate: period.getStartDate(),
        Keys.endDate: period.getEndDate(),
      };

  @override
  String get url => baseUrl + path;
}
