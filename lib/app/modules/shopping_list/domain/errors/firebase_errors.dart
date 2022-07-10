import 'package:market_lists/app/core/errors/errors.dart';

class ShoppingListFirebaseFailure extends Failure {
  @override
  final String message;

  ShoppingListFirebaseFailure({this.message = ''});
}

class InvalidShoppingListFirebase extends Failure {
  @override
  final String message;

  InvalidShoppingListFirebase({this.message = ''});
}
