import 'package:market_lists/app/core/errors/errors.dart';

class ShoppingListFailure extends Failure {
  @override
  final String message;

  ShoppingListFailure({this.message = ''});
}

class InvalidShoppingList extends Failure {
  @override
  final String message;

  InvalidShoppingList({this.message = ''});
}
