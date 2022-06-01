import 'package:dartz/dartz.dart';
import 'package:market_lists/app/modules/grocery/domain/entities/grocery.dart';
import 'package:market_lists/app/modules/grocery/domain/errors/errors.dart';
import 'package:market_lists/app/modules/grocery/domain/repositories/grocery_repository.dart';

abstract class AddGroceryToList {
  Future<Either<Failure, Grocery>> call(Grocery grocery);
}

class AddGroceryToListImpl implements AddGroceryToList {
  final GroceryRepository groceryRepository;
  AddGroceryToListImpl(this.groceryRepository);

  @override
  Future<Either<Failure, Grocery>> call(Grocery grocery) async {
    var validateResult = _validateGrocery(grocery);
    if (validateResult != null) return validateResult;
    return await _addGroceryList(grocery);
  }

  Either<Failure, Grocery>? _validateGrocery(Grocery grocery) {
    if (grocery.groceryListId.isEmpty ||
        !grocery.isValidName ||
        !grocery.isValidQuantity) {
      return Left(InvalidGroceryList());
    }
    return null;
  }

  Future<Either<Failure, Grocery>> _addGroceryList(Grocery grocery) async {
    var result = await groceryRepository.addGroceryToList(grocery);
    return result;
  }
}
