import 'package:dartz/dartz.dart';
import 'package:market_lists/app/modules/grocery/domain/entities/grocery.dart';
import 'package:market_lists/app/modules/grocery/domain/errors/errors.dart';
import 'package:market_lists/app/modules/grocery/domain/repositories/grocery_repository.dart';

abstract class UpdateGroceryInList {
  Future<Either<Failure, Unit>> call(Grocery grocery);
}

class UpdateGroceryInListImpl implements UpdateGroceryInList {
  final GroceryRepository groceryRepository;
  UpdateGroceryInListImpl(this.groceryRepository);

  @override
  Future<Either<Failure, Unit>> call(Grocery grocery) async {
    var validateResult = _validateGrocery(grocery);
    if (validateResult != null) return validateResult;
    return await _updateGrocery(grocery);
  }

  Either<Failure, Unit>? _validateGrocery(Grocery grocery) {
    if (!grocery.isValidName ||
        grocery.id.isEmpty ||
        grocery.groceryListId.isEmpty) {
      return Left(InvalidGroceryList());
    }
    return null;
  }

  Future<Either<Failure, Unit>> _updateGrocery(Grocery grocery) async {
    var result = groceryRepository.updateGroceryInList(grocery);
    return result;
  }
}
