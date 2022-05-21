import 'dart:convert';

import 'package:market_lists/app/modules/grocery/domain/entities/grocery.dart';
import 'package:market_lists/app/shared/utils/grocery_type_util.dart';

class GroceryModel extends Grocery {
  GroceryModel({
    super.id,
    required super.name,
    required super.quantity,
    super.price,
    super.type,
  });

  factory GroceryModel.fromGrocery(Grocery grocery) {
    return GroceryModel(
      id: grocery.id,
      name: grocery.name,
      quantity: grocery.quantity,
      type: grocery.type,
      price: grocery.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'type': type != null ? GroceryTypeUtil.toText(type!) : null,
      'price': price,
    };
  }

  factory GroceryModel.fromMap(Map<String, dynamic> map) {
    return GroceryModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      quantity: map['quantity']?.toInt() ?? 0,
      type: map['type'] != null ? GroceryTypeUtil.fromText(map['type']) : null,
      price: map['price']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory GroceryModel.fromJson(String source) =>
      GroceryModel.fromMap(json.decode(source));
}
