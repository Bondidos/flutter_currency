import 'package:flutter_currency/data/models/rate_api.dart';
import 'package:flutter_currency/domain/entities/rate.dart';

class RateModel implements Rate {
  const RateModel({
    required this.curId,
    required this.curAbbr,
    required this.curScale,
    required this.curName,
    required this.actualCurRate,
    required this.alternativeCurRate,
  });

  @override
  final int curId;
  @override
  final String curAbbr;
  @override
  final int curScale;
  @override
  final String curName;
  @override
  final double? actualCurRate;
  @override
  final double? alternativeCurRate;

  factory RateModel.fromActualAndAlternative({
    required RateApi current,
    required RateApi alternative,
  }) =>
      RateModel(
        curId: current.curId,
        curAbbr: current.curAbbr,
        curScale: current.curScale,
        curName: current.curName,
        actualCurRate: current.curOfficialRate,
        alternativeCurRate: alternative.curOfficialRate,
      );
}
