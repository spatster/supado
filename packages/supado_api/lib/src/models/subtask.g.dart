// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subtask.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Subtask _$SubtaskFromJson(Map<String, dynamic> json) => Subtask(
      id: json['id'] as int?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      name: json['name'] as String,
      projectId: json['project_id'] as int,
      finishedAt: json['finishedAt'] == null
          ? null
          : DateTime.parse(json['finishedAt'] as String),
    );

Map<String, dynamic> _$SubtaskToJson(Subtask instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('created_at', instance.createdAt?.toIso8601String());
  val['name'] = instance.name;
  val['project_id'] = instance.projectId;
  val['finishedAt'] = instance.finishedAt?.toIso8601String();
  return val;
}
