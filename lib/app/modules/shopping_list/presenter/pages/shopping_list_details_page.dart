import 'package:easy_market/app/core/l10n/generated/l10n.dart';
import 'package:easy_market/app/modules/shopping_list/presenter/widgets/users_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../shared/widgets/custom_elevated_button/custom_elevated_button.dart';
import '../utils/bottom_sheet_util.dart';
import '../widgets/item_form.dart';
import '../widgets/shared_users.dart';
import '/app/modules/shopping_list/presenter/bloc/items_bloc/items_bloc.dart';
import '/app/modules/shopping_list/presenter/widgets/item_card.dart';
import '/app/modules/shopping_list/shopping_list.dart';
import '/app/shared/entities/base_bloc_state.dart';
import '/app/shared/themes/themes.dart';
import '/app/shared/widgets/confirmation_dialog/confirmation_dialog.dart';
import '/app/shared/widgets/custom_snack_bar/custom_snack_bar.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class ShoppingListDetailsPage extends StatefulWidget {
  final ShoppingList shoppingList;

  const ShoppingListDetailsPage({Key? key, required this.shoppingList})
      : super(key: key);

  @override
  State<ShoppingListDetailsPage> createState() =>
      _ShoppingListDetailsPageState();
}

class _ShoppingListDetailsPageState extends State<ShoppingListDetailsPage> {
  @override
  void initState() {
    final bloc = Modular.get<ItemsBloc>();
    bloc.add(ListenShoppingListItemsEvent(widget.shoppingList.id));
    super.initState();
  }

  Future<void> _openUsersPanel() async {
    await BottomSheetUtil.openBottomSheet(
      context: _scaffoldKey.currentContext!,
      title: AppLocalizations.of(context).collaborators,
      child: const SharedUsers(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        actions: [
          UsersRow(
            users: widget.shoppingList.users.skip(1).toList(),
            onPressed: () => _openUsersPanel(),
          )
        ],
      ),
      body: SafeArea(
        child: BlocListener<ItemsBloc, ItemsState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status == BaseStateStatus.error) {
              getCustomSnackBar(
                context: context,
                message: state.callbackMessage,
                type: SnackBarType.error,
              );
            }
          },
          child: BlocBuilder<ItemsBloc, ItemsState>(
            builder: (bloc, state) {
              return state.when(
                onState: (_) => _BuildScreen(
                  shoppingList: widget.shoppingList,
                  items: state.items,
                ),
                onLoading: () =>
                    const Center(child: CircularProgressIndicator()),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _BuildScreen extends StatelessWidget {
  final ShoppingList shoppingList;
  final List<Item> items;
  const _BuildScreen(
      {Key? key, required this.items, required this.shoppingList})
      : super(key: key);

  Future<void> _onTapDelete({required Item item}) async {
    await showDialog(
      context: _scaffoldKey.currentContext!,
      builder: (context) {
        return ConfirmationDialog(
          title: AppLocalizations.of(context).deleteItem,
          confirmButton: AppLocalizations.of(context).delete,
          message:
              '${AppLocalizations.of(context).wouldYouLikeDelete} ${item.name}?',
          onConfirm: () {
            Modular.to.pop();
            Modular.get<ItemsBloc>().add(DeleteItemEvent(item));
          },
          onCancel: () => Modular.to.pop(),
        );
      },
    );
  }

  Future<void> _onTapUpdate({required Item item}) async {
    final bloc = Modular.get<ItemsBloc>();
    bloc.add(ChangeCurrentItemEvent(item: item));
    await BottomSheetUtil.openBottomSheet(
      context: _scaffoldKey.currentContext!,
      title:
          '${AppLocalizations.of(_scaffoldKey.currentContext!).update} ${item.name}',
      child: ItemForm(onSubmit: () => _updateItem()),
    );
  }

  void _updateItem() {
    final bloc = Modular.get<ItemsBloc>();
    bloc.add(UpdateItemEvent());
    Modular.to.pop();
  }

  void _reorderItems(int oldIndex, int newIndex) {
    final bloc = Modular.get<ItemsBloc>();
    bloc.add(ReorderItemsEvent(oldIndex, newIndex));
  }

  void _onCheck(Item item) {
    final bloc = Modular.get<ItemsBloc>();
    bloc.add(CheckItemEvent(item));
  }

  void _onFilter() {}

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                shoppingList.name,
                style: context.headlineSmall,
              ),
              GestureDetector(
                onTap: () => _onFilter,
                child: const Icon(Icons.filter_alt),
              ),
            ],
          ),
        ),
        Expanded(
          child: ReorderableListView.builder(
            itemCount: items.length,
            onReorder: (oldIndex, newIndex) =>
                _reorderItems(oldIndex, newIndex),
            itemBuilder: (context, index) => ItemCard(
              key: Key(items[index].id),
              item: items[index],
              onTapUpdate: (item) => _onTapUpdate(item: item),
              onTapDelete: (item) => _onTapDelete(item: item),
              onCheck: (item) => _onCheck(item),
            ),
          ),
        ),
        const _CreateButton(),
      ],
    );
  }
}

class _CreateButton extends StatelessWidget {
  const _CreateButton({Key? key}) : super(key: key);

  void _addItem() {
    final bloc = Modular.get<ItemsBloc>();
    bloc.add(AddItemEvent());
    Modular.to.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
      child: CustomElevatedButton(
        width: context.width * 100,
        onTap: () => BottomSheetUtil.openBottomSheet(
          context: _scaffoldKey.currentContext!,
          title: AppLocalizations.of(context).addNewItem,
          child: ItemForm(onSubmit: _addItem),
        ),
        text: AppLocalizations.of(context).addNewItem,
      ),
    );
  }
}
