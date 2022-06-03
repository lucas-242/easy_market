import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:market_lists/app/modules/shopping_list/domain/errors/errors.dart';
import 'package:market_lists/app/modules/shopping_list/shopping_list.dart';
import 'package:mockito/mockito.dart';

import '../../mock_shopping_list_test.dart' as mock;
import '../../mock_shopping_list_test.mocks.dart';

void main() {
  final repository = MockShoppingListRepositoryTest();
  final usecase = CreateShoppingListImpl(repository);

  test('Should return a ShoppingList', () async {
    var shoppingList = mock.shoppingListToCreate;
    when(repository.createShoppingList(any))
        .thenAnswer((_) async => right(shoppingList));

    var result = await usecase(shoppingList);
    expect(result, Right(shoppingList));
  });

  test('Should throw InvalidShoppingList when the list is invalid', () async {
    var shoppingList = ShoppingList(
      name: '',
      items: const [
        Item(name: 'product1', quantity: 5),
        Item(name: 'product2', quantity: 3),
      ],
    );

    var result = await usecase(shoppingList);
    expect(result.leftMap((l) => l is InvalidShoppingList), const Left(true));
  });

  test('Should throw ShoppingListFailure when there are any errors to save',
      () async {
    when(repository.createShoppingList(any))
        .thenAnswer((_) async => left(ShoppingListFailure()));

    var result = await usecase(mock.shoppingListToCreate);
    expect(result.leftMap((l) => l is ShoppingListFailure), const Left(true));
  });
}
