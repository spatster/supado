// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:supado_api/supado_api.dart';

part 'project_type.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ProjectType extends Equatable {
  @JsonKey(includeIfNull: false)
  final int? id;
  @JsonKey(includeIfNull: false)
  final DateTime? createdAt;
  final String name;

  ProjectType({
    this.id,
    this.createdAt,
    required this.name,
  });

  @override
  List<Object?> get props {
    return [id, createdAt, name];
  }
}
