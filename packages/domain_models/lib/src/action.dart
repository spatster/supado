import 'package:equatable/equatable.dart';

class Action extends Equatable {
  final int? id;
  final DateTime createdAt;
  final String name;
  final String description;
  final bool isFavourite;

  Action({
    this.id,
    required this.createdAt,
    required this.name,
    required this.description,
    required this.isFavourite,
  });

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
