import 'package:dartz/dartz.dart';
import 'package:market_lists/app/modules/grocery/domain/entities/grocery.dart';
import 'package:market_lists/app/modules/grocery/domain/entities/grocery_list.dart';
import 'package:market_lists/app/modules/grocery/domain/errors/errors.dart';

abstract class GroceryRepository {
  Future<Either<Failure, List<GroceryList>>> getGroceryLists();
  Either<Failure, Stream<List<GroceryList>>> listenGroceryLists();
  Future<Either<Failure, GroceryList>> createGroceryList(
      GroceryList groceryList);
  Future<Either<Failure, Unit>> updateGroceryList(GroceryList groceryList);
  Future<Either<Failure, Unit>> deleteGroceryList(GroceryList groceryList);
  Future<Either<Failure, Grocery>> addGroceryToList(Grocery grocery);
  Future<Either<Failure, Unit>> updateGroceryInList(Grocery grocery);
}
