import 'package:flutter_currency/app/constants.dart';
import 'package:flutter_currency/domain/entities/currency.dart';
import 'package:flutter_currency/domain/entities/rate.dart';

extension RatesToCurrencyMapper on List<Rate> {
  List<ConverterData> toCurrencyListAndAddBYN() =>
      map((e) => ConverterData.fromRate(e)).toList()
        ..add(const ConverterData(id: byn, curAbbr: 'BYN', rateToByRub: 1));
}
