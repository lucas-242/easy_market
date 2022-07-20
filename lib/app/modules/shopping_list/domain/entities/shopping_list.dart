import 'package:easy_market/app/modules/shopping_list/domain/entities/item.dart';

class ShoppingList {
  final String id;
  final String name;
  final List<Item> items;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String owner;
  final List<String> users;

  ShoppingList({
    this.id = '',
    required this.name,
    List<Item>? items,
    DateTime? createdAt,
    DateTime? updatedAt,
    required this.owner,
    List<String>? users,
  })  : items = items ?? [],
        users = users ?? [],
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  bool get isValidName => name.isNotEmpty;
}
