import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_market/app/modules/shopping_list/domain/usecases/add_collaborator_to_list.dart';
import 'package:easy_market/app/modules/shopping_list/domain/usecases/check_item_in_list.dart';
import 'package:easy_market/app/modules/shopping_list/domain/usecases/listen_collaborators_by_emails.dart';
import 'package:easy_market/app/modules/shopping_list/domain/usecases/remove_collaborator_from_list.dart';
import 'package:easy_market/app/modules/shopping_list/infra/repositories/collaborator_repository_impl.dart';
import '../../core/routes/utils/routes_utils.dart';
import 'domain/usecases/reorder_items_in_list.dart';
import 'presenter/bloc/items_bloc/items_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../core/routes/app_routes.dart';
import 'domain/usecases/add_item_to_list.dart';
import 'domain/usecases/create_shopping_list.dart';
import 'domain/usecases/delete_item_from_list.dart';
import 'domain/usecases/delete_shopping_list.dart';
import 'domain/usecases/get_items_from_list.dart';
import 'domain/usecases/get_shopping_lists.dart';
import 'domain/usecases/listen_items_from_list.dart';
import 'domain/usecases/listen_shopping_lists.dart';
import 'domain/usecases/update_item_in_list.dart';
import 'domain/usecases/update_shopping_list.dart';
import 'external/datasources/firebase/firebase_shopping_list_datasource.dart';
import 'infra/repositories/shopping_list_repository_impl.dart';
import 'presenter/bloc/shopping_list_bloc/shopping_list_bloc.dart';
import 'presenter/pages/shopping_list_details_page.dart';
import 'presenter/pages/shopping_lists_page.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

class ShoppingListModule extends Module {
  @override
  final List<Bind> binds = [
    $AddItemToListImpl,
    $CheckItemInListImpl,
    $CreateShoppingListImpl,
    $DeleteItemFromListImpl,
    $DeleteShoppingListImpl,
    $GetItemsFromListImpl,
    $GetShoppingListsImpl,
    $ListenItemsFromListImpl,
    $ListenShoppingListsImpl,
    $UpdateItemInListImpl,
    $UpdateShoppingListImpl,
    $ReorderItemInListImpl,
    $ShoppingListRepositoryImpl,
    $AddCollaboratorToListImpl,
    $RemoveCollaboratorFromListImpl,
    $ListenCollaboratorsByEmailsImpl,
    $CollaboratorRepositoryImpl,
    BlocBind.singleton(
      (i) => ShoppingListBloc(
        listenShoppingListsUsecase: i<ListenShoppingLists>(),
        createShoppingListUsecase: i<CreateShoppingList>(),
        updateShoppingListUsecase: i<UpdateShoppingList>(),
        deleteShoppingListUsecase: i<DeleteShoppingList>(),
      ),
    ),
    BlocBind.singleton(
      (i) => ItemsBloc(
        listenItemsFromListUsecase: i<ListenItemsFromList>(),
        addItemToListUsecase: i<AddItemToList>(),
        updateItemInListUsecase: i<UpdateItemInList>(),
        deleteItemFromListUsecase: i<DeleteItemFromList>(),
        reorderItemInListUsecase: i<ReorderItemInList>(),
        checkItemInListUsecase: i<CheckItemInList>(),
      ),
    ),
    BindInject(
      (i) => FirebaseShoppingListDatasource(i<FirebaseFirestore>()),
      isSingleton: true,
      isLazy: true,
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(AppRoutes.main, child: (_, __) => const ShoppingListsPage()),
    ChildRoute(
      '${RoutesUtils.lastPathInRoute(AppRoutes.listDetails)}:id',
      child: (context, args) =>
          ShoppingListDetailsPage(shoppingList: args.data['shoppingList']),
      // ShoppingListDetailsPage(shoppingListId: args.params['id']),
    ),
  ];
}
