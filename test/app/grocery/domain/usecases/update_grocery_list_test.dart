import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:market_lists/app/grocery/domain/errors/errors.dart';
import 'package:market_lists/app/grocery/domain/usecases/update_grocery_list.dart';
import 'package:mockito/mockito.dart';

import '../../mock_groceries_test.dart' as mock;
import '../../mock_groceries_test.mocks.dart';

void main() {
  final repository = MockGroceryRepositoryTest();
  final usecase = UpdateGroceryListImpl(repository);

  test('Should update groceryList', () async {
    when(repository.updateGroceryList(any))
        .thenAnswer((_) async => right(unit));

    var result = await usecase(mock.groceryListToUpdate);
    expect(result, const Right(unit));
  });

  test('Should throw InvalidGroceryList when the list is invalid', () async {
    var result = await usecase(mock.groceryListToCreate);
    expect(result.leftMap((l) => l is InvalidGroceryList), const Left(true));
  });

  test('Should throw GroceryListFailure when there are any errors to save',
      () async {
    when(repository.updateGroceryList(any))
        .thenAnswer((_) async => left(GroceryListFailure()));

    var result = await usecase(mock.groceryListToUpdate);
    expect(result.leftMap((l) => l is GroceryListFailure), const Left(true));
  });
}
