part of 'shopping_list_bloc.dart';

class ShoppingListState extends BaseBlocState {
  final List<ShoppingList> shoppingLists;

  ShoppingListState({
    List<ShoppingList>? shoppingLists,
    required super.status,
    super.callbackMessage,
  }) : shoppingLists = shoppingLists ?? [];

  @override
  ShoppingListState copyWith({
    BaseStateStatus? status,
    String? callbackMessage,
    List<ShoppingList>? shoppingLists,
  }) {
    return ShoppingListState(
      status: status ?? this.status,
      callbackMessage: callbackMessage ?? this.callbackMessage,
      shoppingLists: shoppingLists ?? this.shoppingLists,
    );
  }
}
