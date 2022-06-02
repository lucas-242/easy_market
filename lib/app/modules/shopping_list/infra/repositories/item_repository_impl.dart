import 'package:market_lists/app/modules/shopping_list/domain/errors/errors.dart';
import 'package:market_lists/app/modules/shopping_list/domain/entities/item.dart';
import 'package:dartz/dartz.dart';
import 'package:market_lists/app/modules/shopping_list/domain/repositories/item_repository.dart';
import 'package:market_lists/app/modules/shopping_list/infra/datasources/shopping_list_datasource.dart';
import 'package:market_lists/app/modules/shopping_list/infra/models/item_model.dart';

class ItemRepositoryImpl implements ItemRepository {
  final ShoppingListDatasource datasource;

  ItemRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, Item>> addItemToList(Item item) async {
    try {
      var itemToAdd = ItemModel.fromItem(item);
      var result = await datasource.addItemToList(itemToAdd);
      return right(result);
    } catch (e) {
      return left(ShoppingListFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateItemInList(Item item) async {
    try {
      var itemToUpdate = ItemModel.fromItem(item);
      await datasource.updateItemInList(itemToUpdate);
      return right(unit);
    } catch (e) {
      return left(ShoppingListFailure());
    }
  }
}
