import 'package:flutter_currency/data/sources/local/database/rates_dao.dart';
import 'package:flutter_currency/data/sources/local/settings/date_settings.dart';
import 'package:flutter_currency/domain/entities/rates_on_date.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

const ratesOnDateKey = 'rateListKey';

class RatesDaoImpl implements RatesDao {
  final Box<RatesOnDate> ratesBox;
  final DateSettings dateSettings;

  RatesDaoImpl({
    required this.ratesBox,
    required this.dateSettings,
  });

  @override
  RatesOnDate? getRates() {
    if(dateSettings.isCurrentDateActual) return ratesBox.get(ratesOnDateKey);
    return null;
  }

  @override
  void saveRatesOnDate(RatesOnDate rates) =>
      ratesBox.put(ratesOnDateKey, rates);
}
