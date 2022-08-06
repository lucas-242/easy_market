import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:easy_market/app/modules/shopping_list/domain/usecases/check_item_in_list.dart';
import '../../../domain/usecases/listen_items_from_list.dart';
import '../../../domain/usecases/reorder_items_in_list.dart';
import '../../../shopping_list.dart';
import '../../../../../shared/entities/base_bloc_state.dart';
import '../../../../../shared/validators/form_validator.dart';

part 'items_event.dart';
part 'items_state.dart';

class ItemsBloc extends Bloc<ItemsEvent, ItemsState> with FormValidator {
  final ListenItemsFromList listenItemsFromListUsecase;
  final AddItemToList addItemToListUsecase;
  final UpdateItemInList updateItemInListUsecase;
  final DeleteItemFromList deleteItemFromListUsecase;
  final ReorderItemInList reorderItemInListUsecase;
  final CheckItemInList checkItemInListUsecase;

  ItemsBloc({
    required this.listenItemsFromListUsecase,
    required this.addItemToListUsecase,
    required this.updateItemInListUsecase,
    required this.deleteItemFromListUsecase,
    required this.reorderItemInListUsecase,
    required this.checkItemInListUsecase,
  }) : super(ItemsState(status: BaseStateStatus.initial)) {
    on<ListenShoppingListItemsEvent>(_onInit);
    on<AddItemEvent>(_onAddItem);
    on<CheckItemEvent>(_onCheckItem);
    on<UpdateItemEvent>(_onUpdateItem);
    on<DeleteItemEvent>(_onDeleteItem);
    on<ReorderItemsEvent>(_onReorderItems);
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
    await _listenItemsFromList(emit);
  }

  Future<void> _listenItemsFromList(Emitter<ItemsState> emit) async {
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
    await _addItem(emit);
  }

  Future<void> _addItem(Emitter<ItemsState> emit) async {
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
    await _updateItem(emit);
  }

  Future<void> _updateItem(Emitter<ItemsState> emit) async {
    final result = await updateItemInListUsecase(state.currentItem);
    result.fold(
      (error) async => emit(state.copyWith(
          status: BaseStateStatus.error, callbackMessage: error.message)),
      (result) => (result) => emit(state.successState()),
    );
  }

  Future<void> _onReorderItems(
      ReorderItemsEvent event, Emitter<ItemsState> emit) async {
    emit.call(state.copyWith(status: BaseStateStatus.loading));
    final itemsToReorder = _getItemsToReorder(event.oldIndex, event.newIndex);
    await _reorderItems(
      emit: emit,
      item: itemsToReorder['item']!,
      prev: itemsToReorder['prev'],
      next: itemsToReorder['next'],
    );
  }

  Map<String, Item?> _getItemsToReorder(int oldIndex, int newIndex) {
    final itemToUpdate = state.items[oldIndex];
    Item? prevItem;
    Item? nextItem;

    final willBeFirstItem = newIndex == 0;
    final willBeLastItem = state.items.length == newIndex;

    if (willBeFirstItem) {
      nextItem = state.items.first;
    } else if (willBeLastItem) {
      prevItem = state.items.last;
    } else {
      prevItem = state.items[newIndex - 1];
      nextItem = state.items[newIndex];
    }

    return {
      'item': itemToUpdate,
      'prev': prevItem,
      'next': nextItem,
    };
  }

  Future<void> _reorderItems({
    required Emitter<ItemsState> emit,
    required Item item,
    Item? prev,
    Item? next,
  }) async {
    final result = await reorderItemInListUsecase(item, prev: prev, next: next);
    result.fold(
      (error) async => emit(state.copyWith(
          status: BaseStateStatus.error, callbackMessage: error.message)),
      (result) => (result) => emit(state.successState()),
    );
  }

  Future<void> _onCheckItem(
      CheckItemEvent event, Emitter<ItemsState> emit) async {
    emit.call(state.copyWith(status: BaseStateStatus.loading));
    await _checkItem(
      emit: emit,
      itemId: event.item.id,
      shoppingListId: event.item.shoppingListId,
      isChecked: !event.item.isChecked,
    );
  }

  Future<void> _checkItem({
    required String shoppingListId,
    required String itemId,
    required bool isChecked,
    required Emitter<ItemsState> emit,
  }) async {
    final result =
        await checkItemInListUsecase(shoppingListId, itemId, isChecked);
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
