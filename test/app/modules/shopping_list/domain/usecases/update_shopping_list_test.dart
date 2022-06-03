import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:market_lists/app/modules/shopping_list/domain/errors/errors.dart';
import 'package:market_lists/app/modules/shopping_list/domain/usecases/update_shopping_list.dart';
import 'package:mockito/mockito.dart';

import '../../mock_shopping_list_test.dart' as mock;
import '../../mock_shopping_list_test.mocks.dart';

void main() {
  final repository = MockShoppingListRepositoryTest();
  final usecase = UpdateShoppingListImpl(repository);

  test('Should update shoppingList', () async {
    when(repository.updateShoppingList(any))
        .thenAnswer((_) async => right(unit));

    var result = await usecase(mock.shoppingListToUpdate);
    expect(result, const Right(unit));
  });

  test('Should throw InvalidShoppingList when the list is invalid', () async {
    var result = await usecase(mock.shoppingListToCreate);
    expect(result.leftMap((l) => l is InvalidShoppingList), const Left(true));
  });

  test('Should throw ShoppingListFailure when there are any errors to save',
      () async {
    when(repository.updateShoppingList(any))
        .thenAnswer((_) async => left(ShoppingListFailure()));

    var result = await usecase(mock.shoppingListToUpdate);
    expect(result.leftMap((l) => l is ShoppingListFailure), const Left(true));
  });
}
