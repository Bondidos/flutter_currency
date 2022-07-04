import 'package:flutter_currency/data/sources/local/date_storage/provider.dart';
import 'package:flutter_currency/data/sources/remote/api_provider.dart';
import 'package:flutter_currency/data/sources/remote/constants/api_baseurl.dart';
import 'package:flutter_currency/data/sources/remote/api_request_representable.dart';
import 'package:flutter_currency/data/sources/remote/constants/api_endpoint.dart';
import 'package:flutter_currency/data/sources/remote/constants/keys.dart';
import 'package:flutter_currency/data/sources/remote/constants/params.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

const everyDay = 0;

enum OnDate { today, tomorrow, yesterday }

class CurrencyRatesApi implements APIRequestRepresentable {
  final String onDate;

  CurrencyRatesApi._({required this.onDate});

  CurrencyRatesApi.today() : this._(onDate: OnDate.today.toStringAndSave);

  CurrencyRatesApi.yesterday() : this._(onDate: OnDate.yesterday.toStringAndSave);

  CurrencyRatesApi.tomorrow() : this._(onDate: OnDate.tomorrow.toStringAndSave);

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
  String get toStringAndSave {
    DateFormat format = DateFormat("dd.MM.yyyy");
    DateStorage storage = Get.find<DataStorageImpl>();
    DateTime now = DateTime.now();
    switch (this) {
      case OnDate.today:
        {
          storage.setCurrentDate(now);
          return format.format(now);
        }
      case OnDate.yesterday:
        {
          var yesterday = now.subtract(const Duration(days: 1));
          storage.setAlternativeDate(yesterday);
          return format.format(yesterday);
        }
      case OnDate.tomorrow:
        {
          var tomorrow = now.add(const Duration(days: 1));
          storage.setAlternativeDate(tomorrow);
          return format.format(tomorrow);
        }
    }
  }
}
