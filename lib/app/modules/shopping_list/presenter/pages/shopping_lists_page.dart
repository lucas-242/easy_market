import 'package:easy_market/app/core/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:easy_market/app/core/routes/app_routes.dart';
import 'package:easy_market/app/modules/shopping_list/presenter/bloc/shopping_list_bloc.dart';
import 'package:easy_market/app/modules/shopping_list/presenter/widgets/shopping_list_card.dart';
import 'package:easy_market/app/shared/themes/typography_utils.dart';

class ShoppingListsPage extends StatefulWidget {
  const ShoppingListsPage({Key? key}) : super(key: key);

  @override
  State<ShoppingListsPage> createState() => _ShoppingListsPageState();
}

class _ShoppingListsPageState extends State<ShoppingListsPage> {
  late final AuthService _auth;

  @override
  void initState() {
    super.initState();
    _auth = Modular.get<AuthService>();
    final bloc = Modular.get<ShoppingListBloc>();
    bloc.add(ListenShoppingListsEvent());
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<ShoppingListBloc>();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome  ${_auth.user!.name}',
          style: context.titleLarge,
          overflow: TextOverflow.visible,
        ),
        toolbarHeight: kToolbarHeight * 1.3,
        actions: [
          InkWell(
            onTap: () => Modular.get<AuthService>().signOut(),
            child: Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: CircleAvatar(
                backgroundColor: theme.colorScheme.tertiary,
                child: const Icon(Icons.person),
              ),
            ),
          )
        ],
      ),
      body: bloc.state.when(
        onState: _buildList,
        onLoading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

Widget _buildList(ShoppingListState state) {
  return ListView.builder(
    itemCount: state.shoppingLists.length,
    itemBuilder: (context, index) => ShoppingListCard(
      shoppingList: state.shoppingLists[index],
      onTap: (id) => Modular.to
          .pushNamed('${AppRoutes.lists}${AppRoutes.listDetails}$index'),
    ),
  );
}
