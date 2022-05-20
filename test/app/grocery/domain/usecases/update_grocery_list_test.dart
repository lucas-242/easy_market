import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:market_lists/app/grocery/domain/errors/errors.dart';
import 'package:market_lists/app/grocery/domain/usecases/update_grocery_list.dart';
import 'package:market_lists/app/grocery/grocery.dart';
import 'package:mockito/mockito.dart';

import '../../mock_groceries_test.mocks.dart';

void main() {
  final repository = MockGroceryRepositoryTest();
  final usecase = UpdateGroceryListImpl(repository);

  final groceryListMock = GroceryList(
    id: '123',
    name: 'Test',
    groceries: const [
      Grocery(name: 'product1', quantity: 5),
      Grocery(name: 'product2', quantity: 3),
    ],
  );

  test('Should update groceryList', () async {
    when(repository.updateGroceryList(any))
        .thenAnswer((_) async => right(unit));

    var result = await usecase(groceryListMock);
    expect(result, const Right(unit));
  });

  test('Should throw InvalidGroceryList when the list is invalid', () async {
    final groceryList = GroceryList(
      id: '',
      name: 'Test',
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
    when(repository.updateGroceryList(any))
        .thenAnswer((_) async => left(GroceryListFailure()));

    var result = await usecase(groceryListMock);
    expect(result.leftMap((l) => l is GroceryListFailure), const Left(true));
  });
}
