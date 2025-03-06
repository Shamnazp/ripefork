// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecipeModelAdapter extends TypeAdapter<RecipeModel> {
  @override
  final int typeId = 1;

  @override
  RecipeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecipeModel(
      uri: fields[0] as String,
      label: fields[1] as String,
      image: fields[2] as String,
      source: fields[3] as String,
      ingredients: (fields[4] as List).cast<String>(),
      visitedDate: fields[5] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, RecipeModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.uri)
      ..writeByte(1)
      ..write(obj.label)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.source)
      ..writeByte(4)
      ..write(obj.ingredients)
      ..writeByte(5)
      ..write(obj.visitedDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecipeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AddRecipeModelAdapter extends TypeAdapter<AddRecipeModel> {
  @override
  final int typeId = 5;

  @override
  AddRecipeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AddRecipeModel(
      imagePath: fields[0] as String,
      recipeName: fields[1] as String,
      source: fields[2] as String,
      ingredients: (fields[3] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, AddRecipeModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.imagePath)
      ..writeByte(1)
      ..write(obj.recipeName)
      ..writeByte(2)
      ..write(obj.source)
      ..writeByte(3)
      ..write(obj.ingredients);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddRecipeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SavedModelAdapter extends TypeAdapter<SavedModel> {
  @override
  final int typeId = 4;

  @override
  SavedModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SavedModel(
      title: fields[0] as String,
      imageUrl: fields[1] as String,
      cookingTime: fields[2] as int,
      likes: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, SavedModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.imageUrl)
      ..writeByte(2)
      ..write(obj.cookingTime)
      ..writeByte(3)
      ..write(obj.likes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavedModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
