import 'package:flutter_modular/flutter_modular.dart';
import 'package:market_lists/app/core/errors/errors.dart';
import 'package:market_lists/app/modules/shopping_list/domain/entities/shopping_list.dart';
import 'package:dartz/dartz.dart';
import 'package:market_lists/app/modules/shopping_list/domain/errors/errors.dart';
import 'package:market_lists/app/modules/shopping_list/domain/repositories/shopping_list_repository.dart';
import 'package:market_lists/app/modules/shopping_list/infra/datasources/shopping_list_datasource.dart';
import 'package:market_lists/app/modules/shopping_list/infra/models/shopping_list_model.dart';
part 'shopping_list_repository_impl.g.dart';

@Injectable(singleton: false)
class ShoppingListRepositoryImpl implements ShoppingListRepository {
  final ShoppingListDatasource datasource;

  ShoppingListRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, List<ShoppingList>>> getShoppingLists() async {
    try {
      var result = await datasource.getShoppingLists();
      return right(result);
    } catch (e) {
      return left(ShoppingListFailure());
    }
  }

  @override
  Either<Failure, Stream<List<ShoppingList>>> listenShoppingLists() {
    try {
      var result = datasource.listenShoppingLists();
      return right(result);
    } catch (e) {
      return left(ShoppingListFailure());
    }
  }

  @override
  Future<Either<Failure, ShoppingList>> createShoppingList(
      ShoppingList shoppingList) async {
    try {
      var shoppingListToCreate =
          ShoppingListModel.fromShoppingList(shoppingList);
      var result = await datasource.createShoppingList(shoppingListToCreate);
      return right(result);
    } catch (e) {
      return left(ShoppingListFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteShoppingList(
      ShoppingList shoppingList) async {
    try {
      await datasource.deleteShoppingList(shoppingList.id);
      return right(unit);
    } catch (e) {
      return left(ShoppingListFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateShoppingList(
      ShoppingList shoppingList) async {
    try {
      var shoppingListToUpdate =
          ShoppingListModel.fromShoppingList(shoppingList);
      await datasource.updateShoppingList(shoppingListToUpdate);
      return right(unit);
    } catch (e) {
      return left(ShoppingListFailure());
    }
  }
}
