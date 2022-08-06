import 'dart:convert';

import '../../domain/entities/item.dart';
import '../../domain/entities/item_type.dart';
import '../../../../shared/extensions/extensions.dart';
import '../../../../shared/utils/item_type_util.dart';

class ItemModel extends Item {
  ItemModel({
    super.id,
    required super.name,
    required super.quantity,
    super.isChecked,
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
      isChecked: item.isChecked,
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
      'isChecked': isChecked,
      'type': type?.toShortString(),
      'price': price,
      'orderKey': orderKey,
      'shoppingListId': shoppingListId,
    };
  }

  Map<String, dynamic> toUpdate() {
    return {
      'name': name,
      'quantity': quantity,
      'isChecked': isChecked,
      'type': type?.toShortString(),
      'price': price,
      'orderKey': orderKey,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'isChecked': isChecked,
      'type': type?.toShortString(),
      'price': price,
      'shoppingListId': shoppingListId,
    };
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      id: map['id'] ?? '',
      name: map['name'],
      quantity: int.tryParse(map['quantity'].toString()) ?? 0,
      isChecked: map['isChecked'] ?? false,
      type: map['type'] != null ? ItemTypeUtil.toItemType(map['type']) : null,
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
    bool? isChecked,
    ItemType? type,
    double? price,
    String? orderKey,
    String? shoppingListId,
  }) {
    return ItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      isChecked: isChecked ?? this.isChecked,
      type: type ?? this.type,
      price: price ?? this.price,
      orderKey: orderKey ?? this.orderKey,
      shoppingListId: shoppingListId ?? this.shoppingListId,
    );
  }
}
