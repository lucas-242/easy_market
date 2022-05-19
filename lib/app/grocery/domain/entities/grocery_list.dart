import 'package:market_lists/app/grocery/domain/entities/grocery.dart';

class GroceryList {
  final String id;
  final String name;
  final List<Grocery> groceries;
  final DateTime createdAt;
  final DateTime updatedAt;

  GroceryList({
    this.id = '',
    required this.name,
    List<Grocery>? groceries,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : groceries = groceries ?? [],
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();
}
