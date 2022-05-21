import 'package:dartz/dartz.dart';
import 'package:market_lists/app/modules/grocery/domain/entities/grocery_list.dart';
import 'package:market_lists/app/modules/grocery/domain/errors/errors.dart';
import 'package:market_lists/app/modules/grocery/domain/repositories/grocery_repository.dart';

abstract class UpdateGroceryList {
  Future<Either<Failure, Unit>> call(GroceryList groceryList);
}

class UpdateGroceryListImpl implements UpdateGroceryList {
  final GroceryRepository groceryRepository;
  UpdateGroceryListImpl(this.groceryRepository);

  @override
  Future<Either<Failure, Unit>> call(GroceryList groceryList) async {
    var validateResult = _validateGroceryList(groceryList);
    if (validateResult != null) return validateResult;
    return await _updateGroceryList(groceryList);
  }

  Either<Failure, Unit>? _validateGroceryList(GroceryList groceryList) {
    if (!groceryList.isValidName || groceryList.id.isEmpty) {
      return Left(InvalidGroceryList());
    }
    return null;
  }

  Future<Either<Failure, Unit>> _updateGroceryList(
      GroceryList groceryList) async {
    var option = optionOf(groceryList);
    return option.fold(() => Left(GroceryListFailure()), (groceryList) async {
      var result = groceryRepository.updateGroceryList(groceryList);
      return result;
    });
  }
}
