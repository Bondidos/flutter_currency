// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../rate.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RateAdapter extends TypeAdapter<Rate> {
  @override
  final int typeId = 1;

  @override
  Rate read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Rate(
      curId: fields[0] as int,
      curAbbr: fields[1] as String,
      curScale: fields[2] as int,
      curName: fields[3] as String,
      actualCurRate: fields[4] as double?,
      alternativeCurRate: fields[5] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, Rate obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.curId)
      ..writeByte(1)
      ..write(obj.curAbbr)
      ..writeByte(2)
      ..write(obj.curScale)
      ..writeByte(3)
      ..write(obj.curName)
      ..writeByte(4)
      ..write(obj.actualCurRate)
      ..writeByte(5)
      ..write(obj.alternativeCurRate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
