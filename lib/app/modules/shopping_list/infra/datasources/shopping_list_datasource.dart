import 'package:easy_market/app/modules/shopping_list/infra/models/item_model.dart';
import 'package:easy_market/app/modules/shopping_list/infra/models/shopping_list_model.dart';

abstract class ShoppingListDatasource {
  Future<List<ShoppingListModel>> getShoppingLists(String userId);
  Stream<List<ShoppingListModel>> listenShoppingLists(String userId);
  Stream<ShoppingListModel> listenShoppingListById(String id);
  Future<ShoppingListModel> createShoppingList(ShoppingListModel shoppingList);
  Future<void> updateShoppingList(ShoppingListModel shoppingList);
  Future<void> deleteShoppingList(String id);
  Stream<List<ItemModel>> listenItemsFromList(String shoppingListId);
  Future<List<ItemModel>> getItemsFromList(String shoppingListId);
  Future<ItemModel> addItemToList(ItemModel item);
  Future<void> updateItemInList(ItemModel item);
  Future<void> deleteItemFromList(String itemId);
}
