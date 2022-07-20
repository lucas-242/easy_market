import 'package:easy_market/app/modules/shopping_list/domain/repositories/item_repository.dart';
import 'package:easy_market/app/modules/shopping_list/infra/datasources/shopping_list_datasource.dart';
import 'package:easy_market/app/modules/shopping_list/infra/models/item_model.dart';
import 'package:easy_market/app/modules/shopping_list/infra/models/shopping_list_model.dart';
import 'package:easy_market/app/modules/shopping_list/shopping_list.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

class ShoppingListRepositoryTest extends Mock
    implements ShoppingListRepository {}

class ShoppingListDatasourceTest extends Mock
    implements ShoppingListDatasource {}

class ItemRepositoryTest extends Mock implements ItemRepository {}

class StreamShoppingListsTest extends Mock
    implements Stream<List<ShoppingListModel>> {}

class StreamItemTest extends Mock implements Stream<List<ItemModel>> {}

/// ShoppingList without id
ShoppingList get shoppingListToCreate => ShoppingList(
      name: 'Test',
      items: const [
        Item(name: 'product1', quantity: 5),
        Item(name: 'product2', quantity: 3),
      ],
      owner: 'xpto',
    );

/// ShoppingListmodel without id
ShoppingListModel get shoppingListModelToCreate => ShoppingListModel(
      name: 'Test',
      items: [
        ItemModel(name: 'product1', quantity: 5),
        ItemModel(name: 'product2', quantity: 3),
      ],
      owner: 'xpto',
    );

/// ShoppingList with id
ShoppingList get shoppingListToUpdate => ShoppingList(
      id: '123',
      name: 'Test',
      items: const [
        Item(name: 'product1', quantity: 5),
        Item(name: 'product2', quantity: 3),
      ],
      owner: 'xpto',
    );

/// ShoppingListModel with id
ShoppingListModel get shoppingListModelToUpdate => ShoppingListModel(
      id: '123',
      name: 'Test',
      items: [
        ItemModel(name: 'product1', quantity: 5),
        ItemModel(name: 'product2', quantity: 3),
      ],
      owner: 'xpto',
    );

///List of ShoppingList
List<ShoppingList> get shoppingLists => [
      ShoppingList(
        id: '123',
        name: 'Test1',
        items: [
          const Item(name: 'product1', quantity: 5),
          const Item(name: 'product2', quantity: 3),
        ],
        owner: 'xpto',
      ),
      ShoppingList(
        id: '1234',
        name: 'Test2',
        items: [
          const Item(name: 'product1', quantity: 5),
          const Item(name: 'product2', quantity: 3),
        ],
        owner: 'xpto',
      ),
      ShoppingList(
        id: '12345',
        name: 'Test3',
        items: [
          const Item(name: 'product1', quantity: 5),
          const Item(name: 'product2', quantity: 3),
        ],
        owner: 'xpto',
      ),
    ];

///List of ShoppingListModel
List<ShoppingListModel> get shoppingListModelList => [
      ShoppingListModel(
        id: '123',
        name: 'Test1',
        items: [
          ItemModel(name: 'product1', quantity: 5),
          ItemModel(name: 'product2', quantity: 3),
        ],
        owner: 'xpto',
      ),
      ShoppingListModel(
        id: '1234',
        name: 'Test2',
        items: [
          ItemModel(name: 'product1', quantity: 5),
          ItemModel(name: 'product2', quantity: 3),
        ],
        owner: 'xpto',
      ),
      ShoppingListModel(
        id: '12345',
        name: 'Test3',
        items: [
          ItemModel(name: 'product1', quantity: 5),
          ItemModel(name: 'product2', quantity: 3),
        ],
        owner: 'xpto',
      ),
    ];

/// Item without id
Item get itemToAdd => const Item(
      name: 'product1',
      quantity: 5,
      shoppingListId: '123',
    );

/// ItemModel without id
ItemModel get itemModelToAdd => ItemModel(
      name: 'product1',
      quantity: 5,
      shoppingListId: '123',
    );

/// Item with id
Item get itemToUpdate => const Item(
      id: '123',
      name: 'product1',
      quantity: 5,
      shoppingListId: '123',
    );

/// ItemModel with id
ItemModel get itemModelToUpdate => ItemModel(
      id: '123',
      name: 'product1',
      quantity: 5,
      shoppingListId: '123',
    );

///List of ItemModel
List<ItemModel> get itemModelList => [
      ItemModel(
          id: '123', name: 'product1', quantity: 5, shoppingListId: 'abc'),
      ItemModel(
          id: '456', name: 'product1', quantity: 5, shoppingListId: 'def'),
    ];

@GenerateMocks([
  ShoppingListRepositoryTest,
  ShoppingListDatasourceTest,
  ItemRepositoryTest,
  StreamItemTest,
  StreamShoppingListsTest,
])
void main() {}
