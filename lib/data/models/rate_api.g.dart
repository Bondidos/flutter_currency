// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rate_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RateApi _$RateApiFromJson(Map<String, dynamic> json) => RateApi(
      curId: json['Cur_ID'] as int,
      date: json['Date'] as String,
      curAbbr: json['Cur_Abbreviation'] as String,
      curScale: json['Cur_Scale'] as int,
      curName: json['Cur_Name'] as String,
      curOfficialRate: (json['Cur_OfficialRate'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$RateApiToJson(RateApi instance) => <String, dynamic>{
      'Cur_ID': instance.curId,
      'Date': instance.date,
      'Cur_Abbreviation': instance.curAbbr,
      'Cur_Scale': instance.curScale,
      'Cur_Name': instance.curName,
      'Cur_OfficialRate': instance.curOfficialRate,
    };
