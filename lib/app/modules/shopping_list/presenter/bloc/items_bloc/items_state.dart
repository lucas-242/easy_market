part of 'items_bloc.dart';

class ItemsState extends BaseBlocState {
  final List<Item> items;
  final String? shoppingListId;
  final Item itemToAdd;

  ItemsState({
    required super.status,
    this.shoppingListId,
    super.callbackMessage,
    List<Item>? items,
    Item? itemToAdd,
  })  : items = items ?? [],
        itemToAdd =
            itemToAdd ?? const Item(name: '', quantity: 0, orderKey: '');

  @override
  ItemsState copyWith({
    BaseStateStatus? status,
    String? callbackMessage,
    String? shoppingListId,
    List<Item>? items,
    Item? itemToAdd,
  }) {
    return ItemsState(
      status: status ?? this.status,
      callbackMessage: callbackMessage ?? this.callbackMessage,
      shoppingListId: shoppingListId ?? this.shoppingListId,
      items: items ?? this.items,
      itemToAdd: itemToAdd ?? this.itemToAdd,
    );
  }
}
