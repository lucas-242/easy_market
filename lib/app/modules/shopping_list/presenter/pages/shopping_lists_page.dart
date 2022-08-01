import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../shared/widgets/confirmation_dialog/confirmation_dialog.dart';
import '/app/core/routes/app_routes.dart';

import '/app/core/auth/services/auth_service.dart';
import '/app/modules/shopping_list/presenter/widgets/shopping_list_form.dart';
import '/app/modules/shopping_list/shopping_list.dart';
import '/app/shared/entities/base_bloc_state.dart';
import '/app/shared/widgets/custom_snack_bar/custom_snack_bar.dart';
import '/app/modules/shopping_list/presenter/bloc/shopping_list_bloc/shopping_list_bloc.dart';
import '/app/modules/shopping_list/presenter/widgets/shopping_list_card.dart';
import '/app/shared/themes/themes.dart';
import '../utils/bottom_sheet_util.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
      key: _scaffoldKey,
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

  Future<void> _onTapDelete({required ShoppingList shoppingList}) async {
    await showDialog(
      context: _scaffoldKey.currentContext!,
      builder: (context) {
        return ConfirmationDialog(
          title: 'Delete item',
          confirmButton: 'Delete',
          message: 'Would you like to delete ${shoppingList.name}?',
          onConfirm: () {
            Modular.to.pop();
            Modular.get<ShoppingListBloc>()
                .add(DeleteShoppingListEvent(shoppingList));
          },
          onCancel: () => Modular.to.pop(),
        );
      },
    );
  }

  Future<void> _onTapUpdate({required ShoppingList shoppingList}) async {
    final bloc = Modular.get<ShoppingListBloc>();
    bloc.add(ChangeCurrentShoppingListEvent(shoppingList: shoppingList));
    await BottomSheetUtil.openBottomSheet(
      context: _scaffoldKey.currentContext!,
      title: 'Update ${shoppingList.name}',
      child: ShoppingListForm(onSubmit: () => _updateItem()),
    );
  }

  void _updateItem() {
    final bloc = Modular.get<ShoppingListBloc>();
    bloc.add(UpdateShoppingListEvent());
    Modular.to.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const SizedBox(height: 25),
        ListView.builder(
          itemCount: lists.length,
          itemBuilder: (context, index) => ShoppingListCard(
            shoppingList: lists[index],
            onTap: (id) => Modular.to.pushNamed(
              '${AppRoutes.listDetails}$index',
              arguments: {'shoppingList': lists[index]},
            ),
            onTapUpdate: (shoppingList) =>
                _onTapUpdate(shoppingList: shoppingList),
            onTapDelete: (shoppingList) =>
                _onTapDelete(shoppingList: shoppingList),
          ),
        ),
        const Positioned(
          bottom: 25,
          right: 25,
          child: _CreateButton(),
        ),
      ],
    );
  }
}

class _CreateButton extends StatelessWidget {
  const _CreateButton({Key? key}) : super(key: key);

  void _createShoppingList() {
    final bloc = Modular.get<ShoppingListBloc>();
    bloc.add(CreateShoppingListEvent());
    Modular.to.pop();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => BottomSheetUtil.openBottomSheet(
        context: _scaffoldKey.currentContext!,
        title: 'Create new list',
        child: ShoppingListForm(onSubmit: _createShoppingList),
      ),
      child: const Icon(Icons.add),
    );
  }
}
