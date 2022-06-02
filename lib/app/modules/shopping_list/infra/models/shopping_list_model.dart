import 'dart:convert';

import 'package:market_lists/app/modules/shopping_list/domain/entities/shopping_list.dart';
import 'package:market_lists/app/modules/shopping_list/infra/models/item_model.dart';

class ShoppingListModel extends ShoppingList {
  @override
  List<ItemModel> groceries;

  ShoppingListModel({
    required super.name,
    required this.groceries,
    super.id,
    super.createdAt,
    super.updatedAt,
  });

  factory ShoppingListModel.fromShoppingList(ShoppingList shoppingList) {
    return ShoppingListModel(
      id: shoppingList.id,
      name: shoppingList.name,
      groceries: List<ItemModel>.from(
          shoppingList.groceries.map((x) => ItemModel.fromItem(x))),
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
      'groceries': groceries.map((x) => x.toMap()).toList(),
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory ShoppingListModel.fromMap(Map<String, dynamic> map) {
    return ShoppingListModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      groceries: map['groceries'] != null
          ? List<ItemModel>.from(
              map['groceries']?.map((x) => ItemModel.fromMap(x)))
          : [],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ShoppingListModel.fromJson(String source) =>
      ShoppingListModel.fromMap(json.decode(source));

  ShoppingListModel copyWith({
    String? id,
    String? name,
    List<ItemModel>? groceries,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ShoppingListModel(
      id: id ?? this.id,
      name: name ?? this.name,
      groceries: groceries ?? this.groceries,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
