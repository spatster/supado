// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:supado_api/supado_api.dart';

part 'project_status.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ProjectStatus extends Equatable {
  @JsonKey(includeIfNull: false)
  final int id;
  @JsonKey(includeIfNull: false)
  final DateTime? createdAt;
  final DateTime startedAt;
  final DateTime? finishedAt;
  final String description;

  ProjectStatus({
    required this.id,
    this.createdAt,
    required this.startedAt,
    this.finishedAt,
    this.description = '',
  });

  @override
  List<Object?> get props {
    return [id, createdAt, startedAt, finishedAt, description];
  }

  factory ProjectStatus.fromJson(Map<String, dynamic> json) =>
      _$ProjectStatusFromJson(json);
  Map<String, dynamic> toJson() => _$ProjectStatusToJson(this);
}
