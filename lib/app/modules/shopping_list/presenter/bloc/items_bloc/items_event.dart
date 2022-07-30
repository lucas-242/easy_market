part of 'items_bloc.dart';

abstract class ItemsEvent {}

class ListenShoppingListItemsEvent extends ItemsEvent {
  final String shoppingListId;
  ListenShoppingListItemsEvent(this.shoppingListId);
}

class ChangeCurrentItemEvent extends ItemsEvent {
  final Item? item;

  ChangeCurrentItemEvent({this.item});
}

class ReorderItemsEvent extends ItemsEvent {
  final int oldIndex;
  final int newIndex;

  ReorderItemsEvent(this.oldIndex, this.newIndex);
}

class AddItemEvent extends ItemsEvent {}

class UpdateItemEvent extends ItemsEvent {}

class DeleteItemEvent extends ItemsEvent {
  final Item item;

  DeleteItemEvent(this.item);
}

class ChangeNameEvent extends ItemsEvent {
  final String name;

  ChangeNameEvent(this.name);
}

class ChangeQuantityEvent extends ItemsEvent {
  final String quantity;

  ChangeQuantityEvent(this.quantity);
}

class ChangePriceEvent extends ItemsEvent {
  final String price;

  ChangePriceEvent(this.price);
}

class ChangeTypeEvent extends ItemsEvent {
  final ItemType? type;

  ChangeTypeEvent(this.type);
}
