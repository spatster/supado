// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectType _$ProjectTypeFromJson(Map<String, dynamic> json) => ProjectType(
      id: json['id'] as int,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      name: json['name'] as String,
    );

Map<String, dynamic> _$ProjectTypeToJson(ProjectType instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('created_at', instance.createdAt?.toIso8601String());
  val['name'] = instance.name;
  return val;
}
