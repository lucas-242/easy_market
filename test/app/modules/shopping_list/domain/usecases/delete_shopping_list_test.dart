import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_market/app/modules/shopping_list/domain/entities/shopping_list.dart';
import 'package:easy_market/app/modules/shopping_list/domain/errors/errors.dart';
import 'package:easy_market/app/modules/shopping_list/domain/usecases/delete_shopping_list.dart';
import 'package:mockito/mockito.dart';

import '../../../../test_helper.dart';
import '../../mock_shopping_list_test.dart';
import '../../mock_shopping_list_test.mocks.dart';

void main() {
  final itemRepository = MockShoppingListRepository();
  final usecase = DeleteShoppingListImpl(itemRepository);
  TestHelper.loadAppLocalizations();

  final shoppingListMock =
      ShoppingList(id: '123', name: 'name', owner: 'owner');

  test('Should delete ShoppingList', () async {
    when(itemRepository.deleteShoppingList(any))
        .thenAnswer((_) async => right(unit));

    final result = await usecase(shoppingListMock);
    expect(result, const Right(unit));
  });

  test('Should throw InvalidShoppingList when the list is invalid', () async {
    final result = await usecase(shoppingList.copyWith(id: ''));
    expect(result.leftMap((l) => l is InvalidShoppingList), const Left(true));
  });

  test('Should throw DeleteShoppingListFailure when the are any errors to save',
      () async {
    when(itemRepository.deleteShoppingList(any))
        .thenAnswer((_) async => left(DeleteShoppingListFailure('test')));

    final result = await usecase(shoppingListMock);
    expect(result.leftMap((l) => l is DeleteShoppingListFailure),
        const Left(true));
  });
}
