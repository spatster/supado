import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

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

  Project({
    this.id,
    this.createdAt,
    required this.name,
    this.description,
    this.indexNumber = -1,
  });

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);
  Map<String, dynamic> toJson() => _$ProjectToJson(this);

  @override
  List<Object?> get props {
    return [id, createdAt, name, description, indexNumber];
  }
}
