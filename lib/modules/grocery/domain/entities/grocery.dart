import 'package:equatable/equatable.dart';
import 'package:market_lists/modules/grocery/domain/entities/grocery_type.dart';

class Grocery extends Equatable {
  final String id;
  final String name;
  final int quantity;
  final GroceryType? type;
  final double? price;

  const Grocery({
    this.id = '',
    this.name = '',
    this.quantity = 0,
    this.type,
    this.price,
  });

  @override
  List<Object?> get props => [name, quantity, type, price];
}
