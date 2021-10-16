// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_record.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeatherRecordAdapter extends TypeAdapter<WeatherRecord> {
  @override
  final int typeId = 1;

  @override
  WeatherRecord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WeatherRecord(
      type: fields[0] as String,
      temperature: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, WeatherRecord obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.temperature);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherRecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
