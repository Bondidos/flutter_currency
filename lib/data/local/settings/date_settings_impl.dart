import 'package:flutter_currency/data/sources/local/settings/date_settings.dart';
import 'package:get_storage/get_storage.dart';

const alternativeKey = 'alternative';
const currentKey = 'current';
const noCurrentDate = 0;

class DateSettingsImpl implements DateSettings {
  final GetStorage storage;

  DateSettingsImpl({required this.storage});

  @override
  DateTime get alternativeDate =>
      DateTime.fromMillisecondsSinceEpoch(storage.read(alternativeKey));

  @override
  DateTime get currentDate => DateTime.fromMillisecondsSinceEpoch(
      storage.read(currentKey) ?? noCurrentDate);

  @override
  void setAlternativeDate(DateTime date) =>
      storage.write(alternativeKey, date.millisecondsSinceEpoch);

  @override
  void setCurrentDate(DateTime date) =>
      storage.write(currentKey, date.millisecondsSinceEpoch);

  @override
  bool get isTomorrowRatesExists => currentDate.isBefore(alternativeDate);

  @override
  bool get isCurrentDateActual {
    DateTime lastRequestDate = currentDate;
    if (lastRequestDate.millisecondsSinceEpoch == noCurrentDate) return false;
    DateTime dateNow = DateTime.now();
    Duration difference = dateNow.difference(lastRequestDate);
    if (difference > const Duration(days: 1)) return false;
    return true;
  }
}
