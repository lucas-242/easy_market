import 'dart:convert';

import 'package:market_lists/app/modules/shopping_list/domain/entities/item.dart';
import 'package:market_lists/app/modules/shopping_list/domain/entities/item_type.dart';
import 'package:market_lists/app/shared/utils/item_type_util.dart';

class ItemModel extends Item {
  ItemModel({
    super.id,
    required super.name,
    required super.quantity,
    super.price,
    super.type,
    super.shoppingListId,
  });

  factory ItemModel.fromItem(Item item) {
    return ItemModel(
      id: item.id,
      name: item.name,
      quantity: item.quantity,
      type: item.type,
      price: item.price,
      shoppingListId: item.shoppingListId,
    );
  }

  Map<String, dynamic> toMapCreate() {
    return {
      'name': name,
      'quantity': quantity,
      'type': type != null ? ItemTypeUtil.toText(type!) : null,
      'price': price,
      'shoppingListId': shoppingListId,
    };
  }

  Map<String, dynamic> toMapUpdate() {
    return {
      'name': name,
      'quantity': quantity,
      'type': type != null ? ItemTypeUtil.toText(type!) : null,
      'price': price,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'type': type != null ? ItemTypeUtil.toText(type!) : null,
      'price': price,
      'shoppingListId': shoppingListId,
    };
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      id: map['id'],
      name: map['name'],
      quantity: map['quantity']?.toInt() ?? 0,
      type: map['type'] != null ? ItemTypeUtil.fromText(map['type']) : null,
      price: map['price']?.toDouble(),
      shoppingListId: map['shoppingListId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemModel.fromJson(String source) =>
      ItemModel.fromMap(json.decode(source));

  ItemModel copyWith({
    String? id,
    String? name,
    int? quantity,
    ItemType? type,
    double? price,
    String? shoppingListId,
  }) {
    return ItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      type: type ?? this.type,
      price: price ?? this.price,
      shoppingListId: shoppingListId ?? this.shoppingListId,
    );
  }
}
