import 'package:market_lists/app/grocery/domain/entities/grocery_type.dart';

class Grocery {
  final String id;
  final String name;
  final int quantity;
  final GroceryType? type;
  final double? price;

  const Grocery({
    this.id = '',
    required this.name,
    required this.quantity,
    this.type,
    this.price,
  });
}
