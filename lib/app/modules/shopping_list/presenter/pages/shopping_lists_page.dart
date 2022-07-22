import 'package:easy_market/app/core/auth/services/auth_service.dart';
import 'package:easy_market/app/modules/shopping_list/shopping_list.dart';
import 'package:easy_market/app/shared/entities/base_bloc_state.dart';
import 'package:easy_market/app/shared/widgets/custom_snack_bar/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    bloc.add(ListenShoppingListsEvent(_auth.user!.id));
  }

  @override
  Widget build(BuildContext context) {
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
      body: SafeArea(
        child: BlocListener<ShoppingListBloc, ShoppingListState>(
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
          child: BlocBuilder<ShoppingListBloc, ShoppingListState>(
            builder: (bloc, state) {
              return state.when(
                onState: (_) => _BuildScreen(lists: state.shoppingLists),
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
  final List<ShoppingList> lists;
  const _BuildScreen({Key? key, required this.lists}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('aqui paizão');
    return Column(
      children: [
        const SizedBox(height: 25),
        Expanded(
          child: ListView.builder(
            itemCount: lists.length,
            itemBuilder: (context, index) => ShoppingListCard(
              shoppingList: lists[index],
              onTap: (id) => Modular.to.pushNamed(
                  '${AppRoutes.lists}${AppRoutes.listDetails}$index'),
            ),
          ),
        ),
      ],
    );
  }
}
