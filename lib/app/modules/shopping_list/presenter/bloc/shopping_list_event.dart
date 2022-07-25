part of 'shopping_list_bloc.dart';

@immutable
abstract class ShoppingListEvent {}

class ListenShoppingListsEvent extends ShoppingListEvent {
  final String userId;
  ListenShoppingListsEvent(this.userId);
}
