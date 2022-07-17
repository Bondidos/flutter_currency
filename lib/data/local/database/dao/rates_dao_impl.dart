import 'package:flutter_currency/data/sources/local/database/rates_dao.dart';
import 'package:flutter_currency/data/sources/local/settings/date_settings.dart';
import 'package:flutter_currency/domain/entities/rate.dart';
import 'package:flutter_currency/domain/entities/rates_on_date.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rxdart/rxdart.dart';

const ratesOnDateKey = 'ratesOnDateKey';

class RatesDatastoreImpl implements RatesDatastore {
  final Box<RatesOnDate> ratesBox;
  final DateSettings dateSettings;
  final BehaviorSubject<RatesOnDate?> cacheDataStream = BehaviorSubject();


  RatesDatastoreImpl({
    required this.ratesBox,
    required this.dateSettings,
  }) {
    cacheDataStream.add(_readData);
  }

  @override
  Stream<RatesOnDate?> subscribe() => cacheDataStream.stream;

  @override
  void saveRatesOnDate(RatesOnDate rates) {
    ratesBox.put(ratesOnDateKey, rates);
    cacheDataStream.add(_readData);
  }

  RatesOnDate? get _readData {
    if (dateSettings.isCurrentDateActual) return ratesBox.get(ratesOnDateKey);
    return null;
  }

  @override
  List<Rate> fetchCurrencies() => _readData?.rates.cast() ?? [];
}
