import 'package:market_lists/app/modules/shopping_list/domain/entities/item.dart';

class ShoppingList {
  final String id;
  final String name;
  final List<Item> items;
  final DateTime createdAt;
  final DateTime updatedAt;

  ShoppingList({
    this.id = '',
    required this.name,
    List<Item>? items,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : items = items ?? [],
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  bool get isValidName => name.isNotEmpty;
}
