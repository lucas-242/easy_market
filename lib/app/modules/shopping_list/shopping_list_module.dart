import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:easy_market/app/core/routes/app_routes.dart';
import 'package:easy_market/app/modules/shopping_list/domain/usecases/add_item_to_list.dart';
import 'package:easy_market/app/modules/shopping_list/domain/usecases/create_shopping_list.dart';
import 'package:easy_market/app/modules/shopping_list/domain/usecases/delete_item_from_list.dart';
import 'package:easy_market/app/modules/shopping_list/domain/usecases/delete_shopping_list.dart';
import 'package:easy_market/app/modules/shopping_list/domain/usecases/get_items_from_list.dart';
import 'package:easy_market/app/modules/shopping_list/domain/usecases/get_shopping_lists.dart';
import 'package:easy_market/app/modules/shopping_list/domain/usecases/listen_items_from_list.dart';
import 'package:easy_market/app/modules/shopping_list/domain/usecases/listen_shopping_lists.dart';
import 'package:easy_market/app/modules/shopping_list/domain/usecases/update_item_in_list.dart';
import 'package:easy_market/app/modules/shopping_list/domain/usecases/update_shopping_list.dart';
import 'package:easy_market/app/modules/shopping_list/external/datasources/firebase/firebase_shopping_list_datasource.dart';
import 'package:easy_market/app/modules/shopping_list/infra/repositories/item_repository_impl.dart';
import 'package:easy_market/app/modules/shopping_list/infra/repositories/shopping_list_repository_impl.dart';
import 'package:easy_market/app/modules/shopping_list/presenter/bloc/shopping_list_bloc.dart';
import 'package:easy_market/app/modules/shopping_list/presenter/pages/shopping_list_details_page.dart';
import 'package:easy_market/app/modules/shopping_list/presenter/pages/shopping_lists_page.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

class ShoppingListModule extends Module {
  @override
  final List<Bind> binds = [
    $AddItemToListImpl,
    $CreateShoppingListImpl,
    $DeleteItemFromListImpl,
    $DeleteShoppingListImpl,
    $GetItemsFromListImpl,
    $GetShoppingListsImpl,
    $ListenItemsFromListImpl,
    $ListenShoppingListsImpl,
    $UpdateItemInListImpl,
    $UpdateShoppingListImpl,
    $ItemRepositoryImpl,
    $ShoppingListRepositoryImpl,
    BlocBind.singleton(
      (i) => ShoppingListBloc(i<ListenShoppingLists>()),
    ),
    BindInject(
      (i) => FirebaseShoppingListDatasource(i<FirebaseFirestore>()),
      isSingleton: false,
      isLazy: true,
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(AppRoutes.main, child: (_, __) => const ShoppingListsPage()),
    ChildRoute(
      '${AppRoutes.listDetails}:id',
      child: (context, args) =>
          ShoppingListDetailsPage(shoppingListId: args.params['id']),
    ),
  ];
}
