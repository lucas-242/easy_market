import 'package:bloc/bloc.dart';
import 'package:easy_market/app/modules/shopping_list/shopping_list.dart';
import 'package:easy_market/app/shared/entities/base_bloc_state.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'shopping_list_event.dart';
part 'shopping_list_state.dart';

class ShoppingListBloc extends Bloc<ShoppingListEvent, ShoppingListState> {
  final ListenShoppingLists _listenShoppingListsUsecase;

  ShoppingListBloc(this._listenShoppingListsUsecase)
      : super(ShoppingListState(status: BaseStateStatus.initial)) {
    on<ListenShoppingListsEvent>(_onInit);
  }

  _onInit(
      ListenShoppingListsEvent event, Emitter<ShoppingListState> emit) async {
    emit.call(state.copyWith(status: BaseStateStatus.loading));
    await _listenShoppingLists(event.userId, emit);
  }

  Future<void> _listenShoppingLists(
      String userId, Emitter<ShoppingListState> emit) async {
    var result = _listenShoppingListsUsecase(userId);
    await result.fold(
        (failure) async => emit.call(state.copyWith(
            status: BaseStateStatus.error, callbackMessage: failure.message)),
        (stream) async => await emit.forEach(stream,
            onData: (List<ShoppingList> data) => state.copyWith(
                status: BaseStateStatus.success, shoppingLists: data)));
  }
}
