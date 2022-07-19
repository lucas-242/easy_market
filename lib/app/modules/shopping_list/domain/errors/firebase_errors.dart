import 'package:easy_market/app/core/errors/errors.dart';

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
