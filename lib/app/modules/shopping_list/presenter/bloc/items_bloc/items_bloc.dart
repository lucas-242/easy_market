import 'package:bloc/bloc.dart';
import 'package:easy_market/app/modules/shopping_list/domain/entities/item.dart';
import 'package:easy_market/app/modules/shopping_list/domain/usecases/listen_items_from_list.dart';
import 'package:easy_market/app/modules/shopping_list/shopping_list.dart';
import 'package:easy_market/app/shared/entities/base_bloc_state.dart';

part 'items_event.dart';
part 'items_state.dart';

class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
  final ListenItemsFromList _listemItemsFromListUsecase;

  ItemsBloc(this._listemItemsFromListUsecase)
      : super(ItemsState(status: BaseStateStatus.initial)) {
    on<ListenShoppingListItemsEvent>(_onInit);
  }

  Future<void> _onInit(
      ListenShoppingListItemsEvent event, Emitter<ItemsState> emit) async {
    emit.call(state.copyWith(status: BaseStateStatus.loading));
    final result = _listemItemsFromListUsecase(event.shoppingListId);
    result.fold(
        (error) async => emit(state.copyWith(
            status: BaseStateStatus.error, callbackMessage: error.message)),
        (stream) async => await emit.forEach(stream,
            onData: (List<Item> data) =>
                state.copyWith(status: BaseStateStatus.success, items: data)));
  }
}
