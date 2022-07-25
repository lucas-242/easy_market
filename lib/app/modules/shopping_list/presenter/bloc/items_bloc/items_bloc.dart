import 'package:bloc/bloc.dart';
import 'package:easy_market/app/modules/shopping_list/domain/usecases/listen_items_from_list.dart';
import 'package:easy_market/app/modules/shopping_list/shopping_list.dart';
import 'package:easy_market/app/shared/entities/base_bloc_state.dart';

part 'items_event.dart';
part 'items_state.dart';

class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
  final ListenItemsFromList listenItemsFromListUsecase;
  final AddItemToList addItemToListUsecase;
  final UpdateItemInList updateItemInListUsecase;
  final DeleteItemFromList deleteItemFromListUsecase;

  ItemsBloc({
    required this.listenItemsFromListUsecase,
    required this.addItemToListUsecase,
    required this.updateItemInListUsecase,
    required this.deleteItemFromListUsecase,
  }) : super(ItemsState(status: BaseStateStatus.initial)) {
    on<ListenShoppingListItemsEvent>(_onInit);
    on<AddItemEvent>(_onAddItemEvent);
    on<ChangeNameEvent>(_onChangeName);
    on<ChangeTypeEvent>(_onChangeType);
    on<ChangePriceEvent>(_onChangePrice);
    on<ChangeQuantityEvent>(_onChangeQuantity);
  }

  Future<void> _onInit(
      ListenShoppingListItemsEvent event, Emitter<ItemsState> emit) async {
    emit.call(state.copyWith(
      status: BaseStateStatus.loading,
      shoppingListId: event.shoppingListId,
      itemToAdd: state.itemToAdd.copyWith(shoppingListId: event.shoppingListId),
    ));
    await _listenItemsFromList(event, emit);
  }

  Future<void> _listenItemsFromList(
      ListenShoppingListItemsEvent event, Emitter<ItemsState> emit) async {
    final result = listenItemsFromListUsecase(state.shoppingListId!);
    await result.fold(
        (error) async => emit(state.copyWith(
            status: BaseStateStatus.error, callbackMessage: error.message)),
        (stream) async => await emit.forEach(stream,
            onData: (List<Item> data) =>
                state.copyWith(status: BaseStateStatus.success, items: data)));
  }

  Future<void> _onAddItemEvent(
      AddItemEvent event, Emitter<ItemsState> emit) async {
    emit.call(state.copyWith(status: BaseStateStatus.loading));
    await _addItem(event, emit);
  }

  Future<void> _addItem(AddItemEvent event, Emitter<ItemsState> emit) async {
    final result = await addItemToListUsecase(state.itemToAdd);
    result.fold(
      (error) async => emit(state.copyWith(
          status: BaseStateStatus.error, callbackMessage: error.message)),
      (result) => emit(state.copyWith(status: BaseStateStatus.success)),
    );
  }

  void _onChangeName(ChangeNameEvent event, Emitter<ItemsState> emit) {
    emit(state.copyWith(itemToAdd: state.itemToAdd.copyWith(name: event.name)));
  }

  void _onChangeType(ChangeTypeEvent event, Emitter<ItemsState> emit) {
    emit(state.copyWith(itemToAdd: state.itemToAdd.copyWith(type: event.type)));
  }

  void _onChangePrice(ChangePriceEvent event, Emitter<ItemsState> emit) {
    emit(state.copyWith(
        itemToAdd:
            state.itemToAdd.copyWith(price: double.tryParse(event.price))));
  }

  void _onChangeQuantity(ChangeQuantityEvent event, Emitter<ItemsState> emit) {
    emit(state.copyWith(
        itemToAdd:
            state.itemToAdd.copyWith(quantity: int.tryParse(event.quantity))));
  }
}
