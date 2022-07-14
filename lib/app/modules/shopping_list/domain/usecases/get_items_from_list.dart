import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:easy_market/app/modules/shopping_list/domain/entities/item.dart';
import 'package:easy_market/app/core/errors/errors.dart';
import 'package:easy_market/app/modules/shopping_list/domain/repositories/item_repository.dart';
part 'get_items_from_list.g.dart';

abstract class GetItemsFromList {
  Future<Either<Failure, List<Item>>> call(String shoppingListId);
}

@Injectable(singleton: false)
class GetItemsFromListImpl implements GetItemsFromList {
  ItemRepository repository;

  GetItemsFromListImpl(this.repository);

  @override
  Future<Either<Failure, List<Item>>> call(String shoppingListId) async {
    var result = await repository.getItemsFromList(shoppingListId);
    return result;
  }
}
