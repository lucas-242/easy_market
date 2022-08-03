import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_market/app/modules/shopping_list/domain/errors/errors.dart';
import 'package:easy_market/app/modules/shopping_list/shopping_list.dart';
import 'package:mockito/mockito.dart';

import '../../mock_shopping_list_test.dart';
import '../../mock_shopping_list_test.mocks.dart';

void main() {
  final repository = MockShoppingListRepository();
  final usecase = CreateShoppingListImpl(repository);

  test('Should return a ShoppingList', () async {
    final list = shoppingList;
    when(repository.createShoppingList(any))
        .thenAnswer((_) async => right(list));

    final result = await usecase(list);
    expect(result, Right(list));
  });

  test('Should throw InvalidShoppingList when the list is invalid', () async {
    final shoppingListMock = shoppingList.copyWith(owner: '');
    final result = await usecase(shoppingListMock);
    expect(result.leftMap((l) => l is InvalidShoppingList), const Left(true));
  });

  test(
      'Should throw CreateShoppingListFailure when there are any errors to save',
      () async {
    when(repository.createShoppingList(any))
        .thenAnswer((_) async => left(CreateShoppingListFailure('test')));

    final result = await usecase(shoppingList);
    expect(result.leftMap((l) => l is CreateShoppingListFailure),
        const Left(true));
  });
}
