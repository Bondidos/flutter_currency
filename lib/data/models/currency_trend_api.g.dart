// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_trend_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrencyTrendApi _$CurrencyTrendApiFromJson(Map<String, dynamic> json) =>
    CurrencyTrendApi(
      id: json['Cur_ID'] as int,
      date: json['Date'] as String,
      rate: (json['Cur_OfficialRate'] as num).toDouble(),
    );

Map<String, dynamic> _$CurrencyTrendApiToJson(CurrencyTrendApi instance) =>
    <String, dynamic>{
      'Cur_ID': instance.id,
      'Date': instance.date,
      'Cur_OfficialRate': instance.rate,
    };
