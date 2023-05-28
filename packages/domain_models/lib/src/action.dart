import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'action.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ActionX extends Equatable {
  @JsonKey(includeIfNull: false)
  final int? id;
  @JsonKey(includeIfNull: false)
  final DateTime? createdAt;
  final String name;
  @JsonKey(includeIfNull: false)
  final String? description;
  final bool isFavourite;
  final int indexNumber;

  ActionX({
    this.id,
    this.createdAt,
    required this.name,
    this.description,
    this.isFavourite = false,
    this.indexNumber = -1,
  });

  factory ActionX.fromJson(Map<String, dynamic> json) =>
      _$ActionXFromJson(json);
  Map<String, dynamic> toJson() => _$ActionXToJson(this);

  @override
  List<Object?> get props {
    return [id, createdAt, name, description, isFavourite, indexNumber];
  }
}
