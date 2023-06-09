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
      projectType: json['project_type'] == null
          ? null
          : ProjectType.fromJson(json['project_type'] as Map<String, dynamic>),
      name: json['name'] as String,
      projectTypeId: json['project_type_id'] as int,
      description: json['description'] as String?,
      indexNumber: json['index_number'] as int? ?? -1,
      subtasks: (json['project_subtasks'] as List<dynamic>?)
              ?.map((e) => Subtask.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      statuses: (json['statuses'] as List<dynamic>?)
              ?.map((e) => ProjectStatus.fromJson(e as Map<String, dynamic>))
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
  val['project_type_id'] = instance.projectTypeId;
  return val;
}
