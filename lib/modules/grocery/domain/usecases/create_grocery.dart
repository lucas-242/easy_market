import 'package:market_lists/modules/grocery/domain/entities/grocery.dart';
import 'package:market_lists/modules/grocery/domain/repositories/grocery_repository.dart';

class CreateGrocery {
  final GroceryRepository _groceryRepository;
  CreateGrocery({required GroceryRepository groceryRepository})
      : _groceryRepository = groceryRepository;

  Future<Grocery> call(Grocery grocery) async {
    return await _groceryRepository.create(grocery);
  }
}
