// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'action.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActionX _$ActionXFromJson(Map<String, dynamic> json) => ActionX(
      id: json['id'] as int?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      name: json['name'] as String,
      description: json['description'] as String?,
      isFavourite: json['is_favourite'] as bool? ?? false,
      indexNumber: json['index_number'] as int? ?? -1,
    );

Map<String, dynamic> _$ActionXToJson(ActionX instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('created_at', instance.createdAt?.toIso8601String());
  val['name'] = instance.name;
  writeNotNull('description', instance.description);
  val['is_favourite'] = instance.isFavourite;
  val['index_number'] = instance.indexNumber;
  return val;
}
