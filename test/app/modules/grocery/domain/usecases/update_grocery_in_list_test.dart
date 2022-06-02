import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:market_lists/app/modules/grocery/domain/entities/grocery.dart';
import 'package:market_lists/app/modules/grocery/domain/errors/errors.dart';
import 'package:market_lists/app/modules/grocery/domain/usecases/update_grocery_in_list.dart';
import 'package:mockito/mockito.dart';

import '../../mock_groceries_test.dart' as mock;
import '../../mock_groceries_test.mocks.dart';

void main() {
  final repository = MockGroceryRepositoryTest();
  final usecase = UpdateGroceryInListImpl(repository);

  test('Should update grocery', () async {
    when(repository.updateGroceryInList(any))
        .thenAnswer((_) async => right(unit));

    var result = await usecase(mock.groceryToUpdate);
    expect(result, const Right(unit));
  });

  test('Should throw InvalidGroceryList when the grocery is invalid', () async {
    var grocery = const Grocery(
      name: 'product1',
      quantity: 0,
      groceryListId: '',
    );

    var result = await usecase(grocery);
    expect(result.leftMap((l) => l is InvalidGroceryList), const Left(true));
  });

  test('Should throw GroceryListFailure when there are any errors to save',
      () async {
    when(repository.updateGroceryInList(any))
        .thenAnswer((_) async => left(GroceryListFailure()));

    var result = await usecase(mock.groceryToUpdate);
    expect(result.leftMap((l) => l is GroceryListFailure), const Left(true));
  });
}
