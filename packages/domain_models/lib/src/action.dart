import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'action.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ActionX extends Equatable {
  final int? id;
  final DateTime createdAt;
  final String name;
  final String? description;
  final bool isFavourite;

  ActionX({
    this.id,
    required this.createdAt,
    required this.name,
    required this.description,
    required this.isFavourite,
  });

  factory ActionX.fromJson(Map<String, dynamic> json) =>
      _$ActionXFromJson(json);
  Map<String, dynamic> toJson() => _$ActionXToJson(this);

  @override
  List<Object?> get props {
    return [
      id,
      createdAt,
      name,
      description,
      isFavourite,
    ];
  }
}
