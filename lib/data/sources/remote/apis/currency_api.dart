import 'package:flutter_currency/data/sources/remote/api_provider.dart';
import 'package:flutter_currency/data/sources/remote/constants/api_baseurl.dart';
import 'package:flutter_currency/data/sources/remote/api_request_representable.dart';
import 'package:flutter_currency/data/sources/remote/constants/api_endpoint.dart';
import 'package:flutter_currency/data/sources/remote/constants/keys.dart';
import 'package:flutter_currency/data/sources/remote/constants/params.dart';
import 'package:intl/intl.dart';

const everyDay = 0;

enum OnDate { today, tomorrow, yesterday }

class CurrencyRatesApi implements APIRequestRepresentable {
  final String onDate;

  CurrencyRatesApi._({required this.onDate});

  CurrencyRatesApi.today() : this._(onDate: OnDate.today.asString);

  CurrencyRatesApi.yesterday() : this._(onDate: OnDate.yesterday.asString);

  CurrencyRatesApi.tomorrow() : this._(onDate: OnDate.tomorrow.asString);

  @override
  get body => null;

  @override
  String get baseUrl => APIBaseUrl.currencyRates;

  @override
  Map<String, String>? get headers => {};

  @override
  HTTPMethod get method => HTTPMethod.get;

  @override
  String get path => APIEndPoint.currencyEndpoint;

  @override
  Map<String, String>? get query => {
    Keys.onDate : onDate,
    Keys.periodicity : Parameters.everyDay
  };

  @override
  String get url => baseUrl + path;

  @override
  Future request() => APIProvider.instance.request(this);
}

extension GetDateString on OnDate {
  String get asString {
    DateFormat format = DateFormat("dd.MM.yyyy");
    var now = DateTime.now();
    switch (this) {
      case OnDate.today:
        return format.format(now);
      case OnDate.yesterday:
        {
          var yesterday = now.subtract(const Duration(days: 1));
          return format.format(yesterday);
        }
      case OnDate.tomorrow:
        {
          var tomorrow = now.add(const Duration(days: 1));
          return format.format(tomorrow);
        }
    }
  }
}
