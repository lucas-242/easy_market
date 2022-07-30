import 'package:easy_market/app/core/errors/errors.dart';

class InvalidShoppingList extends Failure {
  @override
  final String message;

  InvalidShoppingList({this.message = 'Invalid shopping list'});
}

class GetShoppingListFailure extends Failure {
  @override
  final String message;

  GetShoppingListFailure(this.message);
}

class CreateShoppingListFailure extends Failure {
  @override
  final String message;

  CreateShoppingListFailure(this.message);
}

class UpdateShoppingListFailure extends Failure {
  @override
  final String message;

  UpdateShoppingListFailure(this.message);
}

class DeleteShoppingListFailure extends Failure {
  @override
  final String message;

  DeleteShoppingListFailure(this.message);
}

class GetItemsFailure extends Failure {
  @override
  final String message;

  GetItemsFailure(this.message);
}

class AddItemFailure extends Failure {
  @override
  final String message;

  AddItemFailure(this.message);
}

class UpdateItemFailure extends Failure {
  @override
  final String message;

  UpdateItemFailure(this.message);
}

class DeleteItemFailure extends Failure {
  @override
  final String message;

  DeleteItemFailure(this.message);
}

class ReorderItemFailure extends Failure {
  @override
  final String message;

  ReorderItemFailure(this.message);
}

abstract class ShoppingListErrorMessages {
  static String get oneItemNeedToBeInformed =>
      'At least one previous or next item needs to be informed';
}
