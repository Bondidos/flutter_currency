import 'package:flutter_currency/data/sources/local/settings/date_settings.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

const alternativeKey = 'alternative';
const currentKey = 'current';

class DateSettingsImpl extends GetxService implements DateSettings {
  final GetStorage storage;

  DateSettingsImpl({required this.storage});

  @override
  DateTime get alternativeDate =>
      DateTime.fromMillisecondsSinceEpoch(storage.read(alternativeKey));

  @override
  DateTime get currentDate =>
      DateTime.fromMillisecondsSinceEpoch(storage.read(currentKey));

  @override
  void setAlternativeDate(DateTime date) =>
      storage.write(alternativeKey, date.millisecondsSinceEpoch);

  @override
  void setCurrentDate(DateTime date) =>
      storage.write(currentKey, date.millisecondsSinceEpoch);

  @override
  bool get isTomorrowRatesExists => currentDate.isBefore(alternativeDate);
}
