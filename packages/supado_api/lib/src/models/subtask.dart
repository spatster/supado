// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'subtask.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Subtask extends Equatable {
  @JsonKey(includeIfNull: false)
  final int? id;
  @JsonKey(includeIfNull: false)
  final DateTime? createdAt;
  final String name;
  final int projectId;
  DateTime? finishedAt;

  changeStatus() {
    finishedAt = finishedAt == null ? DateTime.now() : null;
  }

  Subtask({
    this.id,
    this.createdAt,
    required this.name,
    required this.projectId,
    this.finishedAt,
  });

  factory Subtask.fromJson(Map<String, dynamic> json) =>
      _$SubtaskFromJson(json);
  Map<String, dynamic> toJson() => _$SubtaskToJson(this);

  @override
  List<Object?> get props {
    return [id, createdAt, name, projectId, finishedAt];
  }

  Subtask copyWith({
    int? id,
    DateTime? createdAt,
    String? name,
    int? projectId,
    DateTime? finished,
  }) {
    return Subtask(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      projectId: projectId ?? this.projectId,
      finishedAt: finished ?? this.finishedAt,
    );
  }
}
