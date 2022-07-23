part of 'items_bloc.dart';

abstract class ItemsEvent {}

class ListenShoppingListItemsEvent extends ItemsEvent {
  final String shoppingListId;
  ListenShoppingListItemsEvent(this.shoppingListId);
}
