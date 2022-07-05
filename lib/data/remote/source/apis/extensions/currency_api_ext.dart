import 'package:flutter_currency/data/remote/source/apis/currency_api.dart';
import 'package:flutter_currency/data/sources/local/settings/date_settings.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

extension GetDateString on OnDate {
  String get toStringAndSave {
    DateFormat format = DateFormat("dd.MM.yyyy");
    DateSettings storage = Get.find();
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
