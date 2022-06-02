import 'package:dartz/dartz.dart';
import 'package:market_lists/app/modules/shopping_list/domain/entities/item.dart';
import 'package:market_lists/app/modules/shopping_list/domain/errors/errors.dart';

abstract class ItemRepository {
  Future<Either<Failure, Item>> addItemToList(Item item);
  Future<Either<Failure, Unit>> updateItemInList(Item item);
}
