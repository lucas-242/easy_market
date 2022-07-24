import 'package:easy_market/app/modules/shopping_list/presenter/bloc/items_bloc/items_bloc.dart';
import 'package:easy_market/app/modules/shopping_list/presenter/widgets/item_form.dart';
import 'package:easy_market/app/shared/entities/base_bloc_state.dart';
import 'package:easy_market/app/shared/themes/themes.dart';
import 'package:easy_market/app/shared/widgets/custom_snack_bar/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:easy_market/app/modules/shopping_list/shopping_list.dart';
import 'package:easy_market/app/shared/extensions/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

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

  void _openAddItemModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
      builder: ((context) => const _BottomSheet()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.shoppingList.name,
          style: context.titleLarge,
        ),
        actions: [
          IconButton(
            onPressed: () => _openAddItemModal(),
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 25),
        Expanded(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: ((context, index) => _Item(item: items[index])),
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

class _BottomSheet extends StatelessWidget {
  const _BottomSheet({Key? key}) : super(key: key);

  void _addItem(BuildContext context) {
    final bloc = Modular.get<ItemsBloc>();
    bloc.add(AddItemEvent());

    //TODO: Pop only when the operation is complete
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
          // padding: MediaQuery.of(context).viewInsets,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Add new item', style: context.titleLarge),
              const SizedBox(height: 25),
              ItemForm(onAdd: () => _addItem(context)),
            ],
          ),
        ),
      ),
    );
  }
}
