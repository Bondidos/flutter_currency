// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../rates_on_date.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RatesOnDateAdapter extends TypeAdapter<RatesOnDate> {
  @override
  final int typeId = 2;

  @override
  RatesOnDate read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RatesOnDate(
      rates: (fields[0] as List).cast<Rate>(),
      currentDate: fields[1] as String,
      alternativeDate: fields[2] as String,
      isTomorrowRatesExists: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, RatesOnDate obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.rates)
      ..writeByte(1)
      ..write(obj.currentDate)
      ..writeByte(2)
      ..write(obj.alternativeDate)
      ..writeByte(3)
      ..write(obj.isTomorrowRatesExists);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RatesOnDateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
