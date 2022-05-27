import 'package:market_lists/app/modules/grocery/domain/entities/grocery_list.dart';
import 'package:market_lists/app/modules/grocery/domain/errors/errors.dart';
import 'package:market_lists/app/modules/grocery/infra/datasources/grocery_datasource.dart';
import 'package:market_lists/app/modules/grocery/infra/models/grocery_list_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesGroceryDatasource implements GroceryDatasource {
  static String groceryListsStorageName = 'groceryLists';

  @override
  Future<GroceryListModel> createGroceryList(GroceryList groceryList) async {
    try {
      var groceryListsToSave =
          await _mergeGroceryListWithStorageOnes(groceryList);
      await _saveGroceryLists(groceryListsToSave);
      return GroceryListModel.fromGroceryList(groceryList);
    } catch (e) {
      throw GroceryListFailure(message: e.toString());
    }
  }

  Future<List<GroceryListModel>> _mergeGroceryListWithStorageOnes(
      GroceryList groceryList) async {
    var storageGroceryLists = await _getGroceryLists();
    storageGroceryLists.add(GroceryListModel.fromGroceryList(groceryList));
    return storageGroceryLists;
  }

  Future<void> _saveGroceryLists(List<GroceryListModel> groceryLists) async {
    var toSave = groceryLists.map((e) => e.toJson()).toList();
    await _persistGroceryListsInStorage(toSave);
  }

  Future<void> _persistGroceryListsInStorage(List<String> groceryLists) async {
    var preferences = await _getSharePreferencesInstance();
    var wasSuccessful =
        await preferences.setStringList(groceryListsStorageName, groceryLists);
    if (!wasSuccessful) {
      throw Exception('Error to persist data in the store');
    }
  }

  @override
  Future<void> updateGroceryList(GroceryList groceryList) async {
    // TODO: implement updateGroceryList
    throw UnimplementedError();
  }

  @override
  Future<void> deleteGroceryList(String id) {
    // TODO: implement deleteGroceryList
    throw UnimplementedError();
  }

  Future<SharedPreferences> _getSharePreferencesInstance() async {
    var preferences = await SharedPreferences.getInstance();
    return preferences;
  }

  Future<List<GroceryListModel>> _getGroceryLists() async {
    var listsFromStorage = await _getGroceryListsFromStrorage();
    var result =
        listsFromStorage.map((e) => GroceryListModel.fromJson(e)).toList();
    return result;
  }

  Future<List<String>> _getGroceryListsFromStrorage() async {
    var preferences = await _getSharePreferencesInstance();
    var result = preferences.getStringList(groceryListsStorageName) ?? [];
    return result;
  }
}
