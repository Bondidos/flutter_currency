import 'package:json_annotation/json_annotation.dart';

part 'currency_api.g.dart';

@JsonSerializable()
class CurrencyApi {
  @JsonKey(name: "Cur_ID")
  final int curId;
  @JsonKey(name: "Cur_Abbreviation")
  final String curAbbr;
  @JsonKey(name: "Cur_Scale")
  final int curScale;
  @JsonKey(name: "Cur_Name")
  final String curName;
  @JsonKey(name: "Cur_DateEnd")
  final String curDateEnd;
  @JsonKey(name: "Cur_Periodicity")
  final int curPeriodicity;

  CurrencyApi({
    required this.curId,
    required this.curAbbr,
    required this.curScale,
    required this.curName,
    required this.curDateEnd,
    required this.curPeriodicity,
  });

  factory CurrencyApi.fromJson(Map<String, dynamic> json) =>
      _$CurrencyApiFromJson(json);
  Map<String, dynamic> toJson() => _$CurrencyApiToJson(this);
}
