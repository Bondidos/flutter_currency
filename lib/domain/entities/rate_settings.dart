import 'package:hive/hive.dart';

part 'adapters/rate_settings.g.dart';

@HiveType(typeId: 3)
class RateSettings {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String curAbbr;
  @HiveField(2)
  final int curScale;
  @HiveField(3)
  final String curName;
  @HiveField(4)
  final int listPos;
  @HiveField(5)
  final bool isShow;

  RateSettings({
    required this.curAbbr,
    required this.curScale,
    required this.curName,
    required this.id,
    required this.listPos,
    required this.isShow,
  });

  RateSettings changeVisibility() => RateSettings(
        curAbbr: curAbbr,
        curScale: curScale,
        curName: curName,
        id: id,
        listPos: listPos,
        isShow: !isShow,
      );
}
