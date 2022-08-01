part of 'shopping_list_bloc.dart';

class ShoppingListState extends BaseBlocState {
  final List<ShoppingList> shoppingLists;
  final ShoppingList currentShoppingList;
  final String userId;

  ShoppingListState({
    List<ShoppingList>? shoppingLists,
    required super.status,
    super.callbackMessage,
    ShoppingList? currentShoppingList,
    String? userId,
  })  : shoppingLists = shoppingLists ?? [],
        userId = userId ?? '',
        currentShoppingList =
            currentShoppingList ?? ShoppingList(name: '', owner: '');

  @override
  ShoppingListState copyWith({
    BaseStateStatus? status,
    String? callbackMessage,
    List<ShoppingList>? shoppingLists,
    ShoppingList? currentShoppingList,
    String? userId,
  }) {
    return ShoppingListState(
      status: status ?? this.status,
      callbackMessage: callbackMessage ?? this.callbackMessage,
      shoppingLists: shoppingLists ?? this.shoppingLists,
      currentShoppingList: currentShoppingList ?? this.currentShoppingList,
      userId: userId ?? this.userId,
    );
  }

  ShoppingListState successState() {
    return ShoppingListState(
      status: BaseStateStatus.success,
      shoppingLists: shoppingLists,
      currentShoppingList: ShoppingList(
        name: '',
        owner: userId,
      ),
    );
  }
}
