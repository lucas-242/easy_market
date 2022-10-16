import '../../../../shared/widgets/custom_elevated_button/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../core/l10n/generated/l10n.dart';
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
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Center(
          child: Text(
            AppLocalizations.of(context).groceryLists,
            style: context.headlineSmall,
            overflow: TextOverflow.visible,
          ),
        ),
        toolbarHeight: kToolbarHeight * 1.3,
        leading: const UserButton(),
        actions: const [LogoutButton()],
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

class UserButton extends StatelessWidget {
  const UserButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: IconButton(
        onPressed: () => null,
        icon: const Icon(Icons.person),
      ),
    );
  }
}

class LogoutButton extends StatelessWidget {
  const LogoutButton({Key? key}) : super(key: key);

  Future<void> _onTapLogout() async {
    await showDialog(
      context: _scaffoldKey.currentContext!,
      builder: (context) {
        return ConfirmationDialog(
          title: AppLocalizations.of(context).logout,
          confirmButton: AppLocalizations.of(context).logout,
          message: AppLocalizations.of(context).logoutConfirmation,
          onConfirm: () {
            Modular.to.pop();
            Modular.get<AuthService>().signOut();
          },
          onCancel: () => Modular.to.pop(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: IconButton(
        onPressed: () => _onTapLogout(),
        icon: const Icon(Icons.logout),
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
          title: '${AppLocalizations.of(context).delete} item',
          confirmButton: AppLocalizations.of(context).delete,
          message:
              '${AppLocalizations.of(context).wouldYouLikeDelete} ${shoppingList.name}?',
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
      title:
          '${AppLocalizations.of(_scaffoldKey.currentContext!).update} ${shoppingList.name}',
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
    return Column(
      children: [
        const SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
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
        ),
        const _CreateButton(),
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
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
      child: CustomElevatedButton(
        width: context.width * 100,
        onTap: () => BottomSheetUtil.openBottomSheet(
          context: _scaffoldKey.currentContext!,
          title: AppLocalizations.of(context).createList,
          child: ShoppingListForm(onSubmit: _createShoppingList),
        ),
        text: AppLocalizations.of(context).createList,
      ),
    );
  }
}
