// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectStatus _$ProjectStatusFromJson(Map<String, dynamic> json) =>
    ProjectStatus(
      id: json['id'] as int,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      startedAt: DateTime.parse(json['started_at'] as String),
      finishedAt: json['finished_at'] == null
          ? null
          : DateTime.parse(json['finished_at'] as String),
      description: json['description'] as String? ?? '',
    );

Map<String, dynamic> _$ProjectStatusToJson(ProjectStatus instance) {
  final val = <String, dynamic>{
    'id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('created_at', instance.createdAt?.toIso8601String());
  val['started_at'] = instance.startedAt.toIso8601String();
  val['finished_at'] = instance.finishedAt?.toIso8601String();
  val['description'] = instance.description;
  return val;
}
