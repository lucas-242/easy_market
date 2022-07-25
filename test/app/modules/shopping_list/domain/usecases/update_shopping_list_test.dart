import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_market/app/modules/shopping_list/domain/errors/errors.dart';
import 'package:easy_market/app/modules/shopping_list/domain/usecases/update_shopping_list.dart';
import 'package:mockito/mockito.dart';

import '../../mock_shopping_list_test.dart';
import '../../mock_shopping_list_test.mocks.dart';

void main() {
  final repository = MockShoppingListRepository();
  final usecase = UpdateShoppingListImpl(repository);

  test('Should update shoppingList', () async {
    when(repository.updateShoppingList(any))
        .thenAnswer((_) async => right(unit));

    final result = await usecase(shoppingList);
    expect(result, const Right(unit));
  });

  test('Should throw InvalidShoppingList when the list is invalid', () async {
    final result = await usecase(shoppingList.copyWith(name: ''));
    expect(result.leftMap((l) => l is InvalidShoppingList), const Left(true));
  });

  test(
      'Should throw UpdateShoppingListFailure when there are any errors to save',
      () async {
    when(repository.updateShoppingList(any))
        .thenAnswer((_) async => left(UpdateShoppingListFailure('test')));

    final result = await usecase(shoppingList);
    expect(result.leftMap((l) => l is UpdateShoppingListFailure),
        const Left(true));
  });
}
