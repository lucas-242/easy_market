class Failure implements Exception {
  final String message;

  Failure({this.message = ''});
}

class ShoppingListFailure extends Failure {
  ShoppingListFailure({String message = ''}) : super(message: message);
}

class InvalidShoppingList extends Failure {}
