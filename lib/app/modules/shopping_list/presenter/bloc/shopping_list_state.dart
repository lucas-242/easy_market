part of 'shopping_list_bloc.dart';

@immutable
abstract class ShoppingListState {
  final List<ShoppingList> shoppingLists;
  final String? errorMessage;

  const ShoppingListState({this.shoppingLists = const [], this.errorMessage});

  T when<T>({
    T Function(ShoppingListState state)? onState,
    T Function(ErrorState error)? onError,
    T Function()? onLoading,
  });
}

class ListedState extends ShoppingListState {
  const ListedState(
      {required List<ShoppingList> shoppingLists, String? errorMessage})
      : super(shoppingLists: shoppingLists, errorMessage: errorMessage);

  @override
  T when<T>({
    T Function(ShoppingListState state)? onState,
    T Function(ErrorState error)? onError,
    T Function()? onLoading,
  }) {
    return onState!(this);
  }
}

class LoadingState extends ShoppingListState {
  @override
  T when<T>({
    T Function(ShoppingListState state)? onState,
    T Function(ErrorState error)? onError,
    T Function()? onLoading,
  }) {
    return onLoading!();
  }
}

class ErrorState extends ShoppingListState {
  const ErrorState(String? errorMessage) : super(errorMessage: errorMessage);

  @override
  T when<T>({
    T Function(ShoppingListState state)? onState,
    T Function(ErrorState error)? onError,
    T Function()? onLoading,
  }) {
    return onError!(this);
  }
}
