import 'package:flutter_currency/data/sources/local/settings/date_settings.dart';
import 'package:flutter_currency/domain/entities/rate.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeState {
  final List<Rate> rates;
  late final bool isTomorrowRatesExists;
  late final String currentDate;
  late final String alternativeDate;
  final DateSettings storage = Get.find();

  HomeState({required this.rates}) {
    isTomorrowRatesExists = storage.isTomorrowRatesExists;
    currentDate = storage.currentDate.asString();
    alternativeDate = storage.alternativeDate.asString();
  }
}

extension DateToString on DateTime {
  asString() {
    DateFormat format = DateFormat("dd.MM.yyyy");
    return format.format(this);
  }
}
