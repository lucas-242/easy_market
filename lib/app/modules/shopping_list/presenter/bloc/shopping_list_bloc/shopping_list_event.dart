part of 'shopping_list_bloc.dart';

@immutable
abstract class ShoppingListEvent {}

class ListenShoppingListsEvent extends ShoppingListEvent {
  final String userId;
  ListenShoppingListsEvent(this.userId);
}

class ChangeCurrentShoppingListEvent extends ShoppingListEvent {
  final ShoppingList? shoppingList;

  ChangeCurrentShoppingListEvent({this.shoppingList});
}

class CreateShoppingListEvent extends ShoppingListEvent {}

class UpdateShoppingListEvent extends ShoppingListEvent {}

class DeleteShoppingListEvent extends ShoppingListEvent {
  final ShoppingList shoppingList;

  DeleteShoppingListEvent(this.shoppingList);
}

class ChangeNameEvent extends ShoppingListEvent {
  final String name;

  ChangeNameEvent(this.name);
}
