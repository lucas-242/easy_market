import 'package:easy_market/app/modules/shopping_list/presenter/bloc/items_bloc/items_bloc.dart';
import 'package:easy_market/app/modules/shopping_list/presenter/bloc/shopping_list_bloc.dart';
import 'package:easy_market/app/shared/entities/base_bloc_state.dart';
import 'package:easy_market/app/shared/widgets/custom_snack_bar/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:easy_market/app/modules/shopping_list/shopping_list.dart';
import 'package:easy_market/app/shared/themes/typography_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.shoppingList.name,
          style: context.titleLarge,
        ),
        actions: const [
          IconButton(onPressed: null, icon: Icon(Icons.filter_alt)),
          IconButton(onPressed: null, icon: Icon(Icons.more_horiz))
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
            itemBuilder: ((context, index) => ListTile(
                  title: Text(items[index].name),
                  trailing: Text(items[index].quantity.toString()),
                )),
          ),
        ),
      ],
    );
  }
}
