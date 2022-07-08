import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:market_lists/app/modules/shopping_list/domain/entities/item.dart';

class ShoppingListFirebase {
  final String id;
  final String name;
  final List<Item> items;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  ShoppingListFirebase({
    this.id = '',
    required this.name,
    List<Item>? items,
    Timestamp? createdAt,
    Timestamp? updatedAt,
  })  : items = items ?? [],
        createdAt = createdAt ?? Timestamp.now(),
        updatedAt = updatedAt ?? Timestamp.now();

  bool get isValidName => name.isNotEmpty;
}
