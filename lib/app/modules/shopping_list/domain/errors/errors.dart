import 'package:easy_market/app/core/errors/errors.dart';

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
