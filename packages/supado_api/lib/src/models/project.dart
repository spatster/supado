import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:supado_api/supado_api.dart';

part 'project.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Project extends Equatable {
  @JsonKey(includeIfNull: false)
  final int? id;
  @JsonKey(includeIfNull: false)
  final DateTime? createdAt;
  final String name;
  @JsonKey(includeIfNull: false)
  final String? description;
  final int indexNumber;
  @JsonKey(includeToJson: false)
  final List<Subtask> subtasks;

  int get subtasksCount => subtasks.length;
  int get finishedSubtasksCount => subtasks.length - unfinishedSubtasks.length;

  List<Subtask> get unfinishedSubtasks {
    var sortedSubtasks = subtasks.where((t) => t.finishedAt == null).toList();
    sortedSubtasks.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
    return sortedSubtasks;
  }

  List<Subtask> get sortedSubtasks {
    var unfinished = subtasks.where((t) => t.finishedAt == null).toList();
    unfinished.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
    var finished = subtasks.where((t) => t.finishedAt != null).toList();
    finished.sort((a, b) => b.finishedAt!.compareTo(a.finishedAt!));
    return [...unfinished, ...finished];
  }

  Project({
    this.id,
    this.createdAt,
    required this.name,
    this.description,
    this.indexNumber = -1,
    this.subtasks = const [],
  });

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);
  Map<String, dynamic> toJson() => _$ProjectToJson(this);

  @override
  List<Object?> get props {
    return [id, createdAt, name, description, indexNumber, subtasks];
  }
}
