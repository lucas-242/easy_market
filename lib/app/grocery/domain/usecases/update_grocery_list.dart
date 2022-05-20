import 'package:dartz/dartz.dart';
import 'package:market_lists/app/grocery/domain/entities/grocery_list.dart';
import 'package:market_lists/app/grocery/domain/errors/errors.dart';
import 'package:market_lists/app/grocery/domain/repositories/grocery_repository.dart';

abstract class UpdateGroceryList {
  Future<Either<Failure, void>> call(GroceryList groceryList);
}

class UpdateGroceryListImpl implements UpdateGroceryList {
  final GroceryRepository groceryRepository;
  UpdateGroceryListImpl(this.groceryRepository);

  @override
  Future<Either<Failure, void>> call(GroceryList groceryList) async {
    var validateResult = _validateGroceryList(groceryList);
    if (validateResult != null) return validateResult;
    return _updateGroceryList(groceryList);
  }

  Either<Failure, void>? _validateGroceryList(GroceryList groceryList) {
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
