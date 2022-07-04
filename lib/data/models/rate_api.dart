import 'package:json_annotation/json_annotation.dart';
part 'rate_api.g.dart';

@JsonSerializable()
class RateApi {
  @JsonKey(name: "Cur_ID")
  final int curId;
  @JsonKey(name: "Date")
  final String date;
  @JsonKey(name: "Cur_Abbreviation")
  final String curAbbr;
  @JsonKey(name: "Cur_Scale")
  final int curScale;
  @JsonKey(name: "Cur_Name")
  final String curName;
  @JsonKey(name: "Cur_OfficialRate")
  final double? curOfficialRate;

  const RateApi({
    required this.curId,
    required this.date,
    required this.curAbbr,
    required this.curScale,
    required this.curName,
    required this.curOfficialRate,
  });

  factory RateApi.fromJson(Map<String, dynamic> json) =>
      _$RateApiFromJson(json);
  Map<String, dynamic> toJson() => _$RateApiToJson(this);
}
