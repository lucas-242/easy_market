import 'package:dartz/dartz.dart';
import 'package:easy_market/app/core/errors/errors.dart';
import 'package:easy_market/app/modules/shopping_list/domain/repositories/collaborator_repository.dart';
import 'package:easy_market/app/modules/shopping_list/infra/datasources/collaborator_datasource.dart';
import 'package:easy_market/app/modules/shopping_list/infra/datasources/shopping_list_datasource.dart';
import 'package:easy_market/app/modules/shopping_list/infra/models/collaborator_model.dart';
import 'package:easy_market/app/modules/shopping_list/infra/models/item_model.dart';
import 'package:easy_market/app/modules/shopping_list/infra/models/shopping_list_model.dart';
import 'package:easy_market/app/modules/shopping_list/shopping_list.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

class StreamShoppingLists extends Mock
    implements Stream<List<ShoppingListModel>> {}

class StreamItem extends Mock implements Stream<List<ItemModel>> {}

const userEmail = 'user@email.com';

ShoppingListModel get shoppingList => ShoppingListModel(
      id: '123',
      name: 'Test',
      items: const [
        Item(name: 'product1', quantity: 5, orderKey: ''),
        Item(name: 'product2', quantity: 3, orderKey: ''),
      ],
      owner: 'user@email.com',
      users: ['user@email.com'],
    );

List<ShoppingListModel> get shoppingLists =>
    List.generate(10, (index) => shoppingList);

ItemModel get item => ItemModel(
      id: '123item',
      name: 'product1',
      quantity: 5,
      shoppingListId: '123',
      orderKey: 'B',
    );

List<ItemModel> get items => List.generate(10, (index) => item);

CollaboratorModel get collaborator => CollaboratorModel(
    'colaborator1', 'Jotaro Kujo 1', 'jotarokujo_oraoraora1@test.com');

List<CollaboratorModel> get collaborators => List.generate(
      10,
      (index) => CollaboratorModel('colaborator$index', 'Jotaro Kujo $index',
          'jotarokujo_oraoraora$index@test.com'),
    );

@GenerateMocks([
  ShoppingListRepository,
  ShoppingListDatasource,
  StreamItem,
  StreamShoppingLists,
  CollaboratorRepository,
  CollaboratorDatasource,
])
void main() {}
