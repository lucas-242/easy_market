import 'package:easy_market/app/modules/shopping_list/domain/entities/item_type.dart';

class Item {
  final String id;
  final String name;
  final int quantity;
  final ItemType? type;
  final double? price;
  final String orderKey;
  final String shoppingListId;

  const Item({
    this.id = '',
    required this.name,
    required this.quantity,
    this.type,
    this.price,
    required this.orderKey,
    this.shoppingListId = '',
  });

  bool get isValidName => name.isNotEmpty;
  bool get isValidQuantity => quantity > 0;

  Item copyWith({
    String? id,
    String? name,
    int? quantity,
    ItemType? type,
    double? price,
    String? orderKey,
    String? shoppingListId,
  }) {
    return Item(
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
