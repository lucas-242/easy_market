import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:market_lists/app/modules/grocery/domain/errors/errors.dart';
import 'package:market_lists/app/modules/grocery/grocery.dart';
import 'package:mockito/mockito.dart';

import '../../mock_groceries_test.dart' as mock;
import '../../mock_groceries_test.mocks.dart';

void main() {
  final repository = MockGroceryRepositoryTest();
  final usecase = CreateGroceryListImpl(repository);

  test('Should return a GroceryList', () async {
    var groceryList = mock.groceryListToCreate;
    when(repository.createGroceryList(any))
        .thenAnswer((_) async => right(groceryList));

    var result = await usecase(groceryList);
    expect(result, Right(groceryList));
  });

  test('Should throw InvalidGroceryList when the list is invalid', () async {
    var groceryList = GroceryList(
      name: '',
      groceries: const [
        Grocery(name: 'product1', quantity: 5),
        Grocery(name: 'product2', quantity: 3),
      ],
    );

    var result = await usecase(groceryList);
    expect(result.leftMap((l) => l is InvalidGroceryList), const Left(true));
  });

  test('Should throw GroceryListFailure when there are any errors to save',
      () async {
    when(repository.createGroceryList(any))
        .thenAnswer((_) async => left(GroceryListFailure()));

    var result = await usecase(mock.groceryListToCreate);
    expect(result.leftMap((l) => l is GroceryListFailure), const Left(true));
  });
}
