import 'package:flutter_currency/domain/entities/rate.dart';

class ConverterData {
  final int id;
  final String curAbbr;
  final double rateToByRub;

  const ConverterData({
    required this.id,
    required this.curAbbr,
    required this.rateToByRub,
  });

  factory ConverterData.fromRate(Rate rate) => ConverterData(
        id: rate.curId,
        curAbbr: rate.curAbbr,
        rateToByRub:
            rate.actualCurRate ?? rate.alternativeCurRate ?? 0 / rate.curScale,
      );
}
