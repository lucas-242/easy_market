class Failure implements Exception {
  final String message;

  Failure({this.message = ''});
}

class GroceryListFailure extends Failure {
  GroceryListFailure({String message = ''}) : super(message: message);
}

class InvalidGroceryList extends Failure {}
