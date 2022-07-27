part of 'items_bloc.dart';

class ItemsState extends BaseBlocState {
  final List<Item> items;
  final String? shoppingListId;
  final Item currentItem;

  ItemsState({
    required super.status,
    this.shoppingListId,
    super.callbackMessage,
    List<Item>? items,
    Item? currentItem,
  })  : items = items ?? [],
        currentItem = currentItem ??
            const Item(
              name: '',
              quantity: 0,
              orderKey: '',
            );

  @override
  ItemsState copyWith({
    BaseStateStatus? status,
    String? callbackMessage,
    String? shoppingListId,
    List<Item>? items,
    Item? currentItem,
  }) {
    return ItemsState(
      status: status ?? this.status,
      callbackMessage: callbackMessage ?? this.callbackMessage,
      shoppingListId: shoppingListId ?? this.shoppingListId,
      items: items ?? this.items,
      currentItem: currentItem ?? this.currentItem,
    );
  }

  ItemsState successState() {
    return ItemsState(
      status: BaseStateStatus.success,
      shoppingListId: shoppingListId,
      items: items,
      currentItem: Item(
        name: '',
        shoppingListId: shoppingListId!,
      ),
    );
  }
}
