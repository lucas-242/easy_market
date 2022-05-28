import 'package:dartz/dartz.dart';
import 'package:market_lists/app/modules/grocery/domain/entities/grocery_list.dart';
import 'package:market_lists/app/modules/grocery/domain/errors/errors.dart';
import 'package:market_lists/app/modules/grocery/domain/repositories/grocery_repository.dart';

abstract class GetGroceryLists {
  Future<Either<Failure, List<GroceryList>>> call();
}

class GetGroceryListsImpl implements GetGroceryLists {
  GroceryRepository groceryRepository;

  GetGroceryListsImpl(this.groceryRepository);

  @override
  Future<Either<Failure, List<GroceryList>>> call() async {
    var result = await groceryRepository.getGroceryLists();
    return result;
  }
}
