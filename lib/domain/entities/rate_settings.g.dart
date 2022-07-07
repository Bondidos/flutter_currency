// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rate_settings.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RateSettingsAdapter extends TypeAdapter<RateSettings> {
  @override
  final int typeId = 3;

  @override
  RateSettings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RateSettings(
      curAbbr: fields[1] as String,
      curScale: fields[2] as int,
      curName: fields[3] as String,
      id: fields[0] as String,
      listPos: fields[4] as int,
      isShow: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, RateSettings obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.curAbbr)
      ..writeByte(2)
      ..write(obj.curScale)
      ..writeByte(3)
      ..write(obj.curName)
      ..writeByte(4)
      ..write(obj.listPos)
      ..writeByte(5)
      ..write(obj.isShow);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RateSettingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
