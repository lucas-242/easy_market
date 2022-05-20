import 'package:market_lists/app/grocery/domain/errors/errors.dart';
import 'package:market_lists/app/grocery/domain/entities/grocery_list.dart';
import 'package:dartz/dartz.dart';
import 'package:market_lists/app/grocery/domain/repositories/grocery_repository.dart';
import 'package:market_lists/app/grocery/infra/datasources/grocery_datasource.dart';

class GroceryRepositoryImpl implements GroceryRepository {
  final GroceryDatasource datasource;

  GroceryRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, GroceryList>> createGroceryList(
      GroceryList groceryList) async {
    try {
      var result = await datasource.createGroceryList(groceryList);
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
      await datasource.updateGroceryList(groceryList);
      return right(unit);
    } catch (e) {
      return left(GroceryListFailure());
    }
  }
}
