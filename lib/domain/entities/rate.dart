import 'package:hive_flutter/hive_flutter.dart';

part 'adapters/rate.g.dart';

@HiveType(typeId: 1)
class Rate{
  @HiveField(0)
  final int curId;
  @HiveField(1)
  final String curAbbr;
  @HiveField(2)
  final int curScale;
  @HiveField(3)
  final String curName;
  @HiveField(4)
  final double? actualCurRate;
  @HiveField(5)
  final double? alternativeCurRate;

  const Rate({
    required this.curId,
    required this.curAbbr,
    required this.curScale,
    required this.curName,
    required this.actualCurRate,
    required this.alternativeCurRate ,
  });
}