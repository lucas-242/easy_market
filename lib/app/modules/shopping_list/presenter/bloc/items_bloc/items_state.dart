part of 'items_bloc.dart';

class ItemsState extends BaseBlocState {
  List<Item> items;

  ItemsState({required super.status, super.callbackMessage, List<Item>? items})
      : items = items ?? [];

  @override
  ItemsState copyWith(
      {BaseStateStatus? status, String? callbackMessage, List<Item>? items}) {
    return ItemsState(
      status: status ?? this.status,
      callbackMessage: callbackMessage ?? this.callbackMessage,
      items: items ?? this.items,
    );
  }
}
