import 'package:dartz/dartz.dart';

import 'package:market_lists/app/modules/grocery/domain/entities/grocery_list.dart';
import 'package:market_lists/app/modules/grocery/domain/errors/errors.dart';
import 'package:market_lists/app/modules/grocery/domain/repositories/grocery_repository.dart';

abstract class DeleteGroceryList {
  Future<Either<Failure, Unit>> call(GroceryList groceryList);
}

class DeleteGroceryListImpl implements DeleteGroceryList {
  GroceryRepository groceryRepository;

  DeleteGroceryListImpl(this.groceryRepository);

  @override
  Future<Either<Failure, Unit>> call(GroceryList groceryList) async {
    var validateResult = _validateGroceryList(groceryList);
    if (validateResult != null) return validateResult;
    return await _deleteGroceryList(groceryList);
  }

  Either<Failure, Unit>? _validateGroceryList(GroceryList groceryList) {
    if (groceryList.id.isEmpty) return Left(InvalidGroceryList());
    return null;
  }

  Future<Either<Failure, Unit>> _deleteGroceryList(
      GroceryList groceryList) async {
    var option = optionOf(groceryList);
    return option.fold(() => Left(GroceryListFailure()), (groceryList) {
      var result = groceryRepository.deleteGroceryList(groceryList);
      return result;
    });
  }
}
