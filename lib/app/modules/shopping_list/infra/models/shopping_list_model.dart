import 'dart:convert';

import 'package:market_lists/app/modules/shopping_list/domain/entities/shopping_list.dart';
import 'package:market_lists/app/modules/shopping_list/infra/models/item_model.dart';

class ShoppingListModel extends ShoppingList {
  @override
  List<ItemModel> items;

  ShoppingListModel({
    required super.name,
    required this.items,
    super.id,
    super.createdAt,
    super.updatedAt,
  });

  factory ShoppingListModel.fromShoppingList(ShoppingList shoppingList) {
    return ShoppingListModel(
      id: shoppingList.id,
      name: shoppingList.name,
      items: List<ItemModel>.from(
          shoppingList.items.map((x) => ItemModel.fromItem(x))),
      createdAt: shoppingList.createdAt,
      updatedAt: shoppingList.updatedAt,
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
      'items': items.map((x) => x.toMap()).toList(),
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
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
  }) {
    return ShoppingListModel(
      id: id ?? this.id,
      name: name ?? this.name,
      items: items ?? this.items,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
