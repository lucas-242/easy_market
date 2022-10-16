import '../../../../core/l10n/generated/l10n.dart';

import '../../../../core/errors/errors.dart';

class InvalidShoppingList extends Failure {
  @override
  final String message;

  InvalidShoppingList({String? message})
      : message = message ?? AppLocalizations.current.invalidShoppingList;
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

class GetCollaboratorsFailure extends Failure {
  @override
  final String message;

  GetCollaboratorsFailure(this.message);
}

class AddCollaboratorFailure extends Failure {
  @override
  final String message;

  AddCollaboratorFailure(this.message);
}

class RemoveCollaboratorFailure extends Failure {
  @override
  final String message;

  RemoveCollaboratorFailure(this.message);
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

class CheckItemFailure extends Failure {
  @override
  final String message;

  CheckItemFailure(this.message);
}
