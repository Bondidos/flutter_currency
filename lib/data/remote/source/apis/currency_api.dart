import 'package:flutter_currency/data/remote/source/api_request_representable.dart';
import 'package:flutter_currency/data/remote/source/apis/extensions/currency_api_ext.dart';
import 'package:flutter_currency/data/remote/source/constants/api_baseurl.dart';
import 'package:flutter_currency/data/remote/source/constants/api_endpoint.dart';
import 'package:flutter_currency/data/remote/source/constants/keys.dart';
import 'package:flutter_currency/data/remote/source/constants/params.dart';

enum OnDate { today, tomorrow, yesterday }

class CurrencyRatesApi implements APIRequestRepresentable {
  final String onDate;

  CurrencyRatesApi._({required this.onDate});

  CurrencyRatesApi.today() : this._(onDate: OnDate.today.toStringAndSave);

  CurrencyRatesApi.yesterday()
      : this._(onDate: OnDate.yesterday.toStringAndSave);

  CurrencyRatesApi.tomorrow() : this._(onDate: OnDate.tomorrow.toStringAndSave);

  @override
  get body => null;

  @override
  String get baseUrl => APIBaseUrl.bnrBank;

  @override
  Map<String, String>? get headers => {};

  @override
  HTTPMethod get method => HTTPMethod.get;

  @override
  String get path => APIEndPoint.currencyEndpoint;

  @override
  Map<String, String>? get query =>
      {Keys.onDate: onDate, Keys.periodicity: Parameters.everyDay};

  @override
  String get url => baseUrl + path;
}
