import 'package:bloc/bloc.dart';
import 'package:market_lists/app/modules/shopping_list/shopping_list.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'shopping_list_event.dart';
part 'shopping_list_state.dart';

class ShoppingListBloc extends Bloc<ShoppingListEvent, ShoppingListState> {
  final ListenShoppingLists _listenShoppingListsUsecase;

  ShoppingListBloc(this._listenShoppingListsUsecase)
      : super(const ListedState(shoppingLists: [])) {
    on<ListenShoppingListsEvent>(_onInit);
  }

  _onInit(ShoppingListEvent event, Emitter<ShoppingListState> emit) async {
    emit.call(LoadingState());
    await _listenShoppingLists(emit);
  }

  Future<void> _listenShoppingLists(Emitter<ShoppingListState> emit) async {
    var result = _listenShoppingListsUsecase.call();
    await result.fold(
        (failure) async => emit.call(ErrorState(failure.message)),
        (stream) async => await emit.forEach(stream,
            onData: (List<ShoppingList> data) =>
                ListedState(shoppingLists: data)));
  }
}
