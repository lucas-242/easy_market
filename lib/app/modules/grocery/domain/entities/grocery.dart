import 'package:market_lists/app/modules/grocery/domain/entities/grocery_type.dart';

class Grocery {
  final String id;
  final String name;
  final int quantity;
  final GroceryType? type;
  final double? price;
  final String groceryListId;

  const Grocery({
    this.id = '',
    required this.name,
    required this.quantity,
    this.type,
    this.price,
    this.groceryListId = '',
  });

  bool get isValidName => name.isNotEmpty;
  bool get isValidQuantity => quantity > 0;
}
