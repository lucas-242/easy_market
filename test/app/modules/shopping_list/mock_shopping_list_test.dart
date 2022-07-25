import 'package:easy_market/app/modules/shopping_list/infra/datasources/shopping_list_datasource.dart';
import 'package:easy_market/app/modules/shopping_list/infra/models/item_model.dart';
import 'package:easy_market/app/modules/shopping_list/infra/models/shopping_list_model.dart';
import 'package:easy_market/app/modules/shopping_list/shopping_list.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

class StreamShoppingLists extends Mock
    implements Stream<List<ShoppingListModel>> {}

class StreamItem extends Mock implements Stream<List<ItemModel>> {}

const userId = 'userId';

ShoppingListModel get shoppingList => ShoppingListModel(
      id: '123',
      name: 'Test',
      items: const [
        Item(name: 'product1', quantity: 5, orderKey: ''),
        Item(name: 'product2', quantity: 3, orderKey: ''),
      ],
      owner: 'userId',
      users: ['userId'],
    );

List<ShoppingListModel> get shoppingLists =>
    List.generate(10, (index) => shoppingList);

ItemModel get item => ItemModel(
      id: '123item',
      name: 'product1',
      quantity: 5,
      shoppingListId: '123',
      orderKey: 'abc',
    );

List<ItemModel> get items => List.generate(10, (index) => item);

@GenerateMocks([
  ShoppingListRepository,
  ShoppingListDatasource,
  StreamItem,
  StreamShoppingLists,
])
void main() {}
