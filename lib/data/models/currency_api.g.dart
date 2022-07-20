// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrencyApi _$CurrencyApiFromJson(Map<String, dynamic> json) => CurrencyApi(
      curId: json['Cur_ID'] as int,
      curAbbr: json['Cur_Abbreviation'] as String,
      curScale: json['Cur_Scale'] as int,
      curName: json['Cur_Name'] as String,
      curDateEnd: json['Cur_DateEnd'] as String,
      curPeriodicity: json['Cur_Periodicity'] as int,
    );

Map<String, dynamic> _$CurrencyApiToJson(CurrencyApi instance) =>
    <String, dynamic>{
      'Cur_ID': instance.curId,
      'Cur_Abbreviation': instance.curAbbr,
      'Cur_Scale': instance.curScale,
      'Cur_Name': instance.curName,
      'Cur_DateEnd': instance.curDateEnd,
      'Cur_Periodicity': instance.curPeriodicity,
    };
