import 'item_type.dart';

class Item {
  final String id;
  final String name;
  final int quantity;
  final ItemType? type;
  final double? price;
  final String orderKey;
  final bool isChecked;
  final String shoppingListId;

  const Item({
    this.id = '',
    required this.name,
    this.quantity = 0,
    this.isChecked = false,
    this.type,
    this.price,
    this.orderKey = '',
    this.shoppingListId = '',
  });

  bool get isValidName => name.isNotEmpty;
  bool get isValidQuantity => quantity > 0;

  Item copyWith({
    String? id,
    String? name,
    int? quantity,
    bool? isChecked,
    ItemType? type,
    double? price,
    String? orderKey,
    String? shoppingListId,
  }) {
    return Item(
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
