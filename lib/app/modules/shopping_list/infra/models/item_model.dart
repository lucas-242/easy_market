import 'dart:convert';

import '../../domain/entities/item.dart';
import '../../domain/entities/item_type.dart';
import '../../../../shared/utils/item_type_util.dart';

class ItemModel extends Item {
  ItemModel({
    super.id,
    required super.name,
    required super.quantity,
    super.price,
    super.type,
    required super.orderKey,
    super.shoppingListId,
  });

  factory ItemModel.fromItem(Item item) {
    return ItemModel(
      id: item.id,
      name: item.name,
      quantity: item.quantity,
      type: item.type,
      price: item.price,
      orderKey: item.orderKey,
      shoppingListId: item.shoppingListId,
    );
  }

  Map<String, dynamic> toCreate() {
    return {
      'name': name,
      'quantity': quantity,
      'type': type != null ? ItemTypeUtil.toText(type!) : null,
      'price': price,
      'orderKey': orderKey,
      'shoppingListId': shoppingListId,
    };
  }

  Map<String, dynamic> toUpdate() {
    return {
      'name': name,
      'quantity': quantity,
      'type': type != null ? ItemTypeUtil.toText(type!) : null,
      'price': price,
      'orderKey': orderKey,
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
      id: map['id'] ?? '',
      name: map['name'],
      quantity: int.tryParse(map['quantity'].toString()) ?? 0,
      type: map['type'] != null ? ItemTypeUtil.fromText(map['type']) : null,
      price: map['price']?.toDouble(),
      orderKey: map['orderKey'],
      shoppingListId: map['shoppingListId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemModel.fromJson(String source) =>
      ItemModel.fromMap(json.decode(source));

  @override
  ItemModel copyWith({
    String? id,
    String? name,
    int? quantity,
    ItemType? type,
    double? price,
    String? orderKey,
    String? shoppingListId,
  }) {
    return ItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      type: type ?? this.type,
      price: price ?? this.price,
      orderKey: orderKey ?? this.orderKey,
      shoppingListId: shoppingListId ?? this.shoppingListId,
    );
  }
}
