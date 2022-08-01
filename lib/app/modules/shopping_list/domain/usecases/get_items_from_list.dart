import 'package:dartz/dartz.dart';
import '../repositories/shopping_list_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../entities/item.dart';
import '../../../../core/errors/errors.dart';
part 'get_items_from_list.g.dart';

abstract class GetItemsFromList {
  Future<Either<Failure, List<Item>>> call(String shoppingListId);
}

@Injectable(singleton: false)
class GetItemsFromListImpl implements GetItemsFromList {
  ShoppingListRepository repository;

  GetItemsFromListImpl(this.repository);

  @override
  Future<Either<Failure, List<Item>>> call(String shoppingListId) async {
    var result = await repository.getItemsFromList(shoppingListId);
    return result;
  }
}
