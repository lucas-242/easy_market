import 'package:market_lists/app/modules/grocery/domain/errors/errors.dart';
import 'package:market_lists/app/modules/grocery/domain/entities/grocery_list.dart';
import 'package:dartz/dartz.dart';
import 'package:market_lists/app/modules/grocery/domain/repositories/grocery_repository.dart';
import 'package:market_lists/app/modules/grocery/infra/datasources/grocery_datasource.dart';
import 'package:market_lists/app/modules/grocery/infra/models/grocery_list_model.dart';

class GroceryRepositoryImpl implements GroceryRepository {
  final GroceryDatasource datasource;

  GroceryRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, GroceryList>> createGroceryList(
      GroceryList groceryList) async {
    try {
      var groceryListToCreate = GroceryListModel.fromGroceryList(groceryList);
      var result = await datasource.createGroceryList(groceryListToCreate);
      return right(result);
    } catch (e) {
      return left(GroceryListFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteGroceryList(
      GroceryList groceryList) async {
    try {
      await datasource.deleteGroceryList(groceryList.id);
      return right(unit);
    } catch (e) {
      return left(GroceryListFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateGroceryList(
      GroceryList groceryList) async {
    try {
      var groceryListToUpdate = GroceryListModel.fromGroceryList(groceryList);
      await datasource.updateGroceryList(groceryListToUpdate);
      return right(unit);
    } catch (e) {
      return left(GroceryListFailure());
    }
  }
}
