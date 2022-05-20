import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:market_lists/app/grocery/domain/errors/errors.dart';
import 'package:market_lists/app/grocery/grocery.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'create_grocery_list_test.mocks.dart';

class GroceryRepositoryTest extends Mock implements GroceryRepository {}

@GenerateMocks([GroceryRepositoryTest])
void main() {
  final repository = MockGroceryRepositoryTest();
  final usecase = CreateGroceryListImpl(repository);

  final groceryListMock = GroceryList(
    name: 'Test',
    groceries: const [
      Grocery(name: 'product1', quantity: 5),
      Grocery(name: 'product2', quantity: 3),
    ],
  );

  test('Should return a GroceryList', () async {
    when(repository.createGroceryList(any))
        .thenAnswer((_) async => right(groceryListMock));

    var result = await usecase(groceryListMock);
    expect(result, Right(groceryListMock));
  });

  test('Should throw InvalidGroceryList if the list is invalid', () async {
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

  test('Should throw CreateGroceryListFail if there are any error to save',
      () async {
    when(repository.createGroceryList(any))
        .thenAnswer((_) async => left(CreateGroceryListFail()));

    var result = await usecase(groceryListMock);
    expect(result.leftMap((l) => l is CreateGroceryListFail), const Left(true));
  });
}
