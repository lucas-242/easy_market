import 'package:bloc/bloc.dart';
import 'package:easy_market/app/modules/shopping_list/domain/usecases/listen_items_from_list.dart';
import 'package:easy_market/app/modules/shopping_list/shopping_list.dart';
import 'package:easy_market/app/shared/entities/base_bloc_state.dart';
import 'package:easy_market/app/shared/validators/form_validator.dart';

part 'items_event.dart';
part 'items_state.dart';

class ItemsBloc extends Bloc<ItemsEvent, ItemsState> with FormValidator {
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
    on<AddItemEvent>(_onAddItem);
    on<UpdateItemEvent>(_onUpdateItem);
    on<DeleteItemEvent>(_onDeleteItem);
    on<ChangeCurrentItemEvent>(_onChangeCurrentItem);
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
      currentItem:
          state.currentItem.copyWith(shoppingListId: event.shoppingListId),
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
            onData: (List<Item> data) => state.copyWith(
                  status: BaseStateStatus.success,
                  items: data,
                )));
  }

  Future<void> _onAddItem(AddItemEvent event, Emitter<ItemsState> emit) async {
    emit.call(state.copyWith(status: BaseStateStatus.loading));
    await _addItem(event, emit);
  }

  Future<void> _addItem(AddItemEvent event, Emitter<ItemsState> emit) async {
    final result = await addItemToListUsecase(state.currentItem);
    result.fold(
      (error) async => emit(state.copyWith(
          status: BaseStateStatus.error, callbackMessage: error.message)),
      (result) => emit(state.successState()),
    );
  }

  Future<void> _onDeleteItem(
      DeleteItemEvent event, Emitter<ItemsState> emit) async {
    emit.call(state.copyWith(status: BaseStateStatus.loading));
    await _deleteItem(event, emit);
  }

  Future<void> _deleteItem(
      DeleteItemEvent event, Emitter<ItemsState> emit) async {
    final result = await deleteItemFromListUsecase(event.item);
    result.fold(
      (error) async => emit(state.copyWith(
          status: BaseStateStatus.error, callbackMessage: error.message)),
      (result) => (result) => emit(state.successState()),
    );
  }

  Future<void> _onUpdateItem(
      UpdateItemEvent event, Emitter<ItemsState> emit) async {
    emit.call(state.copyWith(status: BaseStateStatus.loading));
    await _updateItem(event, emit);
  }

  Future<void> _updateItem(
      UpdateItemEvent event, Emitter<ItemsState> emit) async {
    final result = await updateItemInListUsecase(state.currentItem);
    result.fold(
      (error) async => emit(state.copyWith(
          status: BaseStateStatus.error, callbackMessage: error.message)),
      (result) => (result) => emit(state.successState()),
    );
  }

  void _onChangeCurrentItem(
      ChangeCurrentItemEvent event, Emitter<ItemsState> emit) {
    Item item = event.item ??
        Item(
          name: '',
          shoppingListId: state.shoppingListId!,
        );
    emit(state.copyWith(currentItem: item));
  }

  void _onChangeName(ChangeNameEvent event, Emitter<ItemsState> emit) {
    emit(state.copyWith(
        currentItem: state.currentItem.copyWith(name: event.name)));
  }

  void _onChangeType(ChangeTypeEvent event, Emitter<ItemsState> emit) {
    emit(state.copyWith(
        currentItem: state.currentItem.copyWith(type: event.type)));
  }

  void _onChangePrice(ChangePriceEvent event, Emitter<ItemsState> emit) {
    emit(state.copyWith(
        currentItem:
            state.currentItem.copyWith(price: double.tryParse(event.price))));
  }

  void _onChangeQuantity(ChangeQuantityEvent event, Emitter<ItemsState> emit) {
    emit(state.copyWith(
        currentItem: state.currentItem
            .copyWith(quantity: int.tryParse(event.quantity))));
  }
}
