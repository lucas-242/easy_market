import 'package:easy_market/app/modules/shopping_list/presenter/bloc/items_bloc/items_bloc.dart';
import 'package:easy_market/app/modules/shopping_list/presenter/widgets/item_form.dart';
import 'package:easy_market/app/shared/entities/base_bloc_state.dart';
import 'package:easy_market/app/shared/themes/themes.dart';
import 'package:easy_market/app/shared/widgets/confirmation_dialog/confirmation_dialog.dart';
import 'package:easy_market/app/shared/widgets/custom_slidable/custom_slidable.dart';
import 'package:easy_market/app/shared/widgets/custom_snack_bar/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:easy_market/app/modules/shopping_list/shopping_list.dart';
import 'package:easy_market/app/shared/extensions/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

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

  Future<void> _onTapAdd({required BuildContext context}) async {
    final bloc = Modular.get<ItemsBloc>();
    bloc.add(ChangeCurrentItemEvent());
    await _openBottomSheet(
      context: context,
      onSubmit: () => _addItem(context),
    );
  }

  void _addItem(BuildContext context) {
    final bloc = Modular.get<ItemsBloc>();
    bloc.add(AddItemEvent());
    Modular.to.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          widget.shoppingList.name,
          style: context.titleLarge,
        ),
        actions: [
          IconButton(
            onPressed: () => _onTapAdd(context: context),
            icon: const Icon(Icons.add),
          ),
          const IconButton(onPressed: null, icon: Icon(Icons.filter_alt)),
          const IconButton(onPressed: null, icon: Icon(Icons.more_horiz))
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
                onState: (_) => _BuildScreen(items: state.items),
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
  final List<Item> items;
  const _BuildScreen({Key? key, required this.items}) : super(key: key);

  Future<void> _onTapDelete({
    required BuildContext context,
    required Item item,
  }) async {
    await showDialog(
      context: context,
      builder: (context) {
        return ConfirmationDialog(
          title: 'Delete item',
          confirmButton: 'Delete',
          message: 'Would you like to delete ${item.name}?',
          onConfirm: () {
            Modular.to.pop();
            Modular.get<ItemsBloc>().add(DeleteItemEvent(item));
          },
          onCancel: () => Modular.to.pop(),
        );
      },
    );
  }

  Future<void> _onTapUpdate({
    required BuildContext context,
    required Item item,
  }) async {
    final bloc = Modular.get<ItemsBloc>();
    bloc.add(ChangeCurrentItemEvent(item: item));
    await _openBottomSheet(
      context: context,
      onSubmit: () => _updateItem(context),
    );
  }

  void _updateItem(BuildContext context) {
    final bloc = Modular.get<ItemsBloc>();
    bloc.add(UpdateItemEvent());
    Modular.to.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 25),
        Expanded(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return CustomSlidable(
                leftPanel: true,
                rightPanel: true,
                onLeftSlide: (context) =>
                    _onTapUpdate(context: context, item: item),
                onRightSlide: (context) =>
                    _onTapDelete(context: context, item: item),
                child: _Item(item: item),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _Item extends StatelessWidget {
  final Item item;
  const _Item({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.name),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            item.quantity.toString(),
            textAlign: TextAlign.end,
          ),
          const SizedBox(height: 5.0),
          Text(
            item.price != null
                ? NumberFormat.simpleCurrency().format(item.price)
                : '',
            textAlign: TextAlign.end,
          ),
        ],
      ),
      subtitle: Text(item.type.toShortString() ?? ''),
    );
  }
}

Future<void> _openBottomSheet({
  required BuildContext context,
  required void Function() onSubmit,
}) async {
  await showModalBottomSheet(
    context: _scaffoldKey.currentContext!,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
    builder: ((dialogContext) => _BottomSheet(onSubmit: onSubmit)),
  );
}

class _BottomSheet extends StatelessWidget {
  final void Function() onSubmit;
  const _BottomSheet({Key? key, required this.onSubmit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Add new item', style: context.titleLarge),
              const SizedBox(height: 25),
              ItemForm(onSubmit: onSubmit),
            ],
          ),
        ),
      ),
    );
  }
}
