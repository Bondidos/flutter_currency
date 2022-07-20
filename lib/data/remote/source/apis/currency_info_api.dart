import 'package:flutter_currency/data/remote/source/api_request_representable.dart';
import 'package:flutter_currency/data/remote/source/constants/api_baseurl.dart';
import 'package:flutter_currency/data/remote/source/constants/api_endpoint.dart';

class CurrencyInfoApi implements APIRequestRepresentable {
  @override
  String get baseUrl => APIBaseUrl.bnrBank;

  @override
  get body => null;

  @override
  Map<String, String>? get headers => {};

  @override
  HTTPMethod get method => HTTPMethod.get;

  @override
  String get path => APIEndPoint.currencyInfoEndpoint;

  @override
  Map<String, String>? get query => {};

  @override
  String get url => baseUrl + path;
}
