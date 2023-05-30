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

  Subtask({
    this.id,
    this.createdAt,
    required this.name,
  });

  factory Subtask.fromJson(Map<String, dynamic> json) =>
      _$SubtaskFromJson(json);
  Map<String, dynamic> toJson() => _$SubtaskToJson(this);

  @override
  List<Object?> get props {
    return [id, createdAt, name];
  }
}
