import 'package:flutter_currency/data/sources/local/database/rates_dao.dart';
import 'package:flutter_currency/data/sources/local/settings/date_settings.dart';
import 'package:flutter_currency/domain/entities/rates_on_date.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rxdart/rxdart.dart';

const ratesOnDateKey = 'ratesOnDateKey';

class RatesDaoImpl implements RatesDao {
  final Box<RatesOnDate> ratesBox;
  final DateSettings dateSettings;
  final BehaviorSubject<RatesOnDate?> ratesStream = BehaviorSubject();

  RatesDaoImpl({
    required this.ratesBox,
    required this.dateSettings,
  });

  @override
  BehaviorSubject<RatesOnDate?> subscribe() => ratesStream..add(_readData());

  @override
  void saveRatesOnDate(RatesOnDate rates) =>
      ratesBox.put(ratesOnDateKey, rates);

  RatesOnDate? _readData(){
    if(dateSettings.isCurrentDateActual) return ratesBox.get(ratesOnDateKey);
    return null;
  }
}
