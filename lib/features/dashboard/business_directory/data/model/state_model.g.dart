// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TalukaAdapter extends TypeAdapter<Taluka> {
  @override
  final int typeId = 0;

  @override
  Taluka read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Taluka(
      id: fields[0] as String,
      name: fields[1] as String,
      areaCode: fields[2] as int,
      userCount: fields[3],
      offerRate: fields[4],
    );
  }

  @override
  void write(BinaryWriter writer, Taluka obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.areaCode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TalukaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DistrictAdapter extends TypeAdapter<District> {
  @override
  final int typeId = 1;

  @override
  District read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return District(
      id: fields[0] as String,
      name: fields[1] as String,
      talukas: (fields[2] as List).cast<Taluka>(),
      isMetro: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, District obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.talukas)
      ..writeByte(3)
      ..write(obj.isMetro);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DistrictAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class StateModelAdapter extends TypeAdapter<StateModel> {
  @override
  final int typeId = 2;

  @override
  StateModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StateModel(
      id: fields[0] as String,
      name: fields[1] as String,
      districts: (fields[2] as List).cast<District>(),
    );
  }

  @override
  void write(BinaryWriter writer, StateModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.districts);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StateModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class StateModelResponseAdapter extends TypeAdapter<StateModelResponse> {
  @override
  final int typeId = 3;

  @override
  StateModelResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StateModelResponse(
      states: (fields[0] as List).cast<StateModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, StateModelResponse obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.states);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StateModelResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
