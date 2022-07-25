import 'dart:convert';

import 'package:easy_market/app/modules/shopping_list/domain/entities/shopping_list.dart';
import 'package:easy_market/app/modules/shopping_list/infra/models/item_model.dart';

class ShoppingListModel extends ShoppingList {
  ShoppingListModel({
    required super.name,
    required super.items,
    super.id,
    super.createdAt,
    super.updatedAt,
    required super.owner,
    super.users,
  });

  factory ShoppingListModel.fromShoppingList(ShoppingList shoppingList) {
    return ShoppingListModel(
      id: shoppingList.id,
      name: shoppingList.name,
      items: shoppingList.items,
      createdAt: shoppingList.createdAt,
      updatedAt: shoppingList.updatedAt,
      owner: shoppingList.owner,
      users: shoppingList.users,
    );
  }

  Map<String, dynamic> toMapCreate() {
    return {
      'name': name,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  Map<String, dynamic> toMapUpdate() {
    return {
      'name': name,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'items': items.map((x) => ItemModel.fromItem(x).toMap()).toList(),
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'owner': owner,
      'users': users,
    };
  }

  factory ShoppingListModel.fromMap(Map<String, dynamic> map) {
    return ShoppingListModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      items: map['items'] != null
          ? List<ItemModel>.from(map['items']?.map((x) => ItemModel.fromMap(x)))
          : [],
      createdAt: map['createdAt'].toDate(),
      updatedAt: map['updatedAt'].toDate(),
      owner: map['owner'],
      users: map['users'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ShoppingListModel.fromJson(String source) =>
      ShoppingListModel.fromMap(json.decode(source));

  ShoppingListModel copyWith({
    String? id,
    String? name,
    List<ItemModel>? items,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? owner,
    List<String>? users,
  }) {
    return ShoppingListModel(
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
