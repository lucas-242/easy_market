import 'package:dartz/dartz.dart';
import 'package:market_lists/app/grocery/domain/entities/grocery_list.dart';
import 'package:market_lists/app/grocery/domain/errors/errors.dart';

abstract class GroceryRepository {
  Future<Either<Failure, GroceryList>> createGroceryList(
      GroceryList groceryList);
  Future<Either<Failure, void>> updateGroceryList(GroceryList groceryList);
  Future<Either<Failure, void>> deleteGroceryList(GroceryList groceryList);
}
