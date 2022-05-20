import 'package:dartz/dartz.dart';
import 'package:market_lists/app/grocery/domain/errors/errors.dart';
import 'package:market_lists/app/grocery/grocery.dart';

abstract class CreateGroceryList {
  Future<Either<Failure, GroceryList>> call(GroceryList groceryList);
}

class CreateGroceryListImpl implements CreateGroceryList {
  final GroceryRepository groceryRepository;
  CreateGroceryListImpl(this.groceryRepository);

  @override
  Future<Either<Failure, GroceryList>> call(GroceryList groceryList) async {
    var validateResult = _validateGroceryList(groceryList);
    if (validateResult != null) return validateResult;
    return await _createGroceryList(groceryList);
  }

  Either<Failure, GroceryList>? _validateGroceryList(GroceryList groceryList) {
    if (!groceryList.isValidName) return Left(InvalidGroceryList());
    return null;
  }

  Future<Either<Failure, GroceryList>> _createGroceryList(
      GroceryList groceryList) async {
    var option = optionOf(groceryList);
    return option.fold(() => Left(CreateGroceryListFail()),
        (groceryList) async {
      var result = await groceryRepository.createGroceryList(groceryList);
      return result;
    });
  }
}
