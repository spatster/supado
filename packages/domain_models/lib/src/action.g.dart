// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'action.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActionX _$ActionXFromJson(Map<String, dynamic> json) => ActionX(
      id: json['id'] as int?,
      createdAt: DateTime.parse(json['created_at'] as String),
      name: json['name'] as String,
      description: json['description'] as String?,
      isFavourite: json['is_favourite'] as bool,
    );

Map<String, dynamic> _$ActionXToJson(ActionX instance) => <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt.toIso8601String(),
      'name': instance.name,
      'description': instance.description,
      'is_favourite': instance.isFavourite,
    };
