// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Project _$ProjectFromJson(Map<String, dynamic> json) => Project(
      id: json['id'] as int?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      name: json['name'] as String,
      description: json['description'] as String?,
      indexNumber: json['index_number'] as int? ?? -1,
      subtasks: (json['subtasks'] as List<dynamic>?)
              ?.map((e) => Subtask.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ProjectToJson(Project instance) {
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
  val['index_number'] = instance.indexNumber;
  return val;
}
