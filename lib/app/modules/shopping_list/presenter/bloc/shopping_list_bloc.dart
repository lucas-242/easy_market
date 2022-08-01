import 'dart:async';

import 'package:bloc/bloc.dart';
import '../../shopping_list.dart';
import '../../../../shared/entities/base_bloc_state.dart';
import '../../../../shared/validators/form_validator.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'shopping_list_event.dart';
part 'shopping_list_state.dart';

class ShoppingListBloc extends Bloc<ShoppingListEvent, ShoppingListState>
    with FormValidator {
  final ListenShoppingLists listenShoppingListsUsecase;
  final CreateShoppingList createShoppingListUsecase;
  final UpdateShoppingList updateShoppingListUsecase;
  final DeleteShoppingList deleteShoppingListUsecase;

  ShoppingListBloc({
    required this.listenShoppingListsUsecase,
    required this.createShoppingListUsecase,
    required this.deleteShoppingListUsecase,
    required this.updateShoppingListUsecase,
  }) : super(ShoppingListState(status: BaseStateStatus.initial)) {
    on<ListenShoppingListsEvent>(_onInit);
    on<CreateShoppingListEvent>(_onCreateShoppingList);
    on<UpdateShoppingListEvent>(_onUpdateShoppingList);
    on<DeleteShoppingListEvent>(_onDeleteShoppingList);
    on<ChangeCurrentShoppingListEvent>(_onChangeCurrentShoppingList);
    on<ChangeNameEvent>(_onChangeName);
  }

  Future<void> _onInit(
      ListenShoppingListsEvent event, Emitter<ShoppingListState> emit) async {
    emit.call(state.copyWith(
      status: BaseStateStatus.loading,
      userId: event.userId,
      currentShoppingList:
          state.currentShoppingList.copyWith(owner: event.userId),
    ));
    await _listenShoppingLists(emit);
  }

  Future<void> _listenShoppingLists(Emitter<ShoppingListState> emit) async {
    var result = listenShoppingListsUsecase(state.userId);
    await result.fold(
        (failure) async => emit.call(state.copyWith(
            status: BaseStateStatus.error, callbackMessage: failure.message)),
        (stream) async => await emit.forEach(stream,
            onData: (List<ShoppingList> data) => state.copyWith(
                status: BaseStateStatus.success, shoppingLists: data)));
  }

  Future<void> _onCreateShoppingList(
      CreateShoppingListEvent event, Emitter<ShoppingListState> emit) async {
    emit.call(state.copyWith(status: BaseStateStatus.loading));
    await _createShoppingList(emit);
  }

  Future<void> _createShoppingList(Emitter<ShoppingListState> emit) async {
    final result = await createShoppingListUsecase(state.currentShoppingList);
    result.fold(
      (error) => emit(state.copyWith(
          status: BaseStateStatus.error, callbackMessage: error.message)),
      (result) => emit(state.successState()),
    );
  }

  Future<void> _onUpdateShoppingList(
      UpdateShoppingListEvent event, Emitter<ShoppingListState> emit) async {
    emit.call(state.copyWith(status: BaseStateStatus.loading));
    await _updateShoppingList(emit);
  }

  Future<void> _updateShoppingList(Emitter<ShoppingListState> emit) async {
    final result = await updateShoppingListUsecase(state.currentShoppingList);
    result.fold(
      (error) => emit(state.copyWith(
          status: BaseStateStatus.error, callbackMessage: error.message)),
      (result) => emit(state.successState()),
    );
  }

  Future<void> _onDeleteShoppingList(
      DeleteShoppingListEvent event, Emitter<ShoppingListState> emit) async {
    emit.call(state.copyWith(status: BaseStateStatus.loading));
    await _deleteShoppingList(event.shoppingList, emit);
  }

  Future<void> _deleteShoppingList(
      ShoppingList shoppingList, Emitter<ShoppingListState> emit) async {
    final result = await deleteShoppingListUsecase(shoppingList);
    result.fold(
      (error) => emit(state.copyWith(
          status: BaseStateStatus.error, callbackMessage: error.message)),
      (result) => emit(state.successState()),
    );
  }

  void _onChangeCurrentShoppingList(
      ChangeCurrentShoppingListEvent event, Emitter<ShoppingListState> emit) {
    ShoppingList shoppingList =
        event.shoppingList ?? ShoppingList(name: '', owner: '');
    emit(state.copyWith(currentShoppingList: shoppingList));
  }

  void _onChangeName(ChangeNameEvent event, Emitter<ShoppingListState> emit) {
    emit(state.copyWith(
        currentShoppingList:
            state.currentShoppingList.copyWith(name: event.name)));
  }
}
