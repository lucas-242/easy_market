import 'package:dartz/dartz.dart';
import 'package:market_lists/app/modules/grocery/domain/entities/grocery_list.dart';
import 'package:market_lists/app/modules/grocery/domain/errors/errors.dart';
import 'package:market_lists/app/modules/grocery/domain/repositories/grocery_repository.dart';

abstract class ListenGroceryLists {
  Either<Failure, Stream<List<GroceryList>>> call();
}

class ListenGroceryListsImpl implements ListenGroceryLists {
  GroceryRepository groceryRepository;

  ListenGroceryListsImpl(this.groceryRepository);

  @override
  Either<Failure, Stream<List<GroceryList>>> call() {
    var result = groceryRepository.listenGroceryLists();
    return result;
  }
}
