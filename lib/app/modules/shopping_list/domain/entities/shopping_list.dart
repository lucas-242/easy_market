import 'package:market_lists/app/modules/shopping_list/domain/entities/item.dart';

class ShoppingList {
  final String id;
  final String name;
  final List<Item> groceries;
  final DateTime createdAt;
  final DateTime updatedAt;

  ShoppingList({
    this.id = '',
    required this.name,
    List<Item>? groceries,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : groceries = groceries ?? [],
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  bool get isValidName => name.isNotEmpty;
}
