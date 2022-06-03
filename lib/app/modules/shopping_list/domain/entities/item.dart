import 'package:market_lists/app/modules/shopping_list/domain/entities/item_type.dart';

class Item {
  final String id;
  final String name;
  final int quantity;
  final ItemType? type;
  final double? price;
  final String shoppingListId;

  const Item({
    this.id = '',
    required this.name,
    required this.quantity,
    this.type,
    this.price,
    this.shoppingListId = '',
  });

  bool get isValidName => name.isNotEmpty;
  bool get isValidQuantity => quantity > 0;
}
