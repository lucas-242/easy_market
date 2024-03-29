import 'item.dart';

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

  List<String> get collaborators => users.skip(1).toList();
  bool get isValidName => name.isNotEmpty;

  ShoppingList copyWith({
    String? id,
    String? name,
    List<Item>? items,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? owner,
    List<String>? users,
  }) {
    return ShoppingList(
      id: id ?? this.id,
      name: name ?? this.name,
      items: items ?? this.items,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      owner: owner ?? this.owner,
      users: users ?? this.users,
    );
  }
}
