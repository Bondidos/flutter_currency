// ignore_for_file: overridden_fields, annotate_overrides

import 'package:flutter_currency/domain/entities/currency_trend.dart';
import 'package:json_annotation/json_annotation.dart';

part 'currency_trend_api.g.dart';

@JsonSerializable()
class CurrencyTrendApi extends CurrencyTrend {
  @JsonKey(name: 'Cur_ID')
  final int id;
  @JsonKey(name: 'Date')
  final String date;
  @JsonKey(name: 'Cur_OfficialRate')
  final double rate;

  CurrencyTrendApi({
    required this.id,
    required this.date,
    required this.rate,
  }) : super(
          id: id,
          date: date,
          rate: rate,
        );

  factory CurrencyTrendApi.fromJson(Map<String, dynamic> json) =>
      _$CurrencyTrendApiFromJson(json);

  Map<String, dynamic> toJson() => _$CurrencyTrendApiToJson(this);
}
