import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_market/app/modules/shopping_list/domain/errors/errors.dart';
import 'package:easy_market/app/modules/shopping_list/domain/usecases/get_shopping_lists.dart';
import 'package:mockito/mockito.dart';

import '../../../../test_helper.dart';
import '../../mock_shopping_list_test.dart';
import '../../mock_shopping_list_test.mocks.dart';

void main() {
  final repository = MockShoppingListRepository();
  final usecase = GetShoppingListsImpl(repository);
  const userId = 'userId';
  TestHelper.loadAppLocalizations();

  test('Should return a List of ShoppingList', () async {
    when(repository.getShoppingLists(userId))
        .thenAnswer((_) async => right(shoppingLists));

    var result = (await usecase(userId)).fold((l) => null, (r) => r);
    expect(result, isNotNull);
    expect(result, isNotEmpty);
  });

  test('Should throw GetShoppingListFailure', () async {
    when(repository.getShoppingLists(userId))
        .thenAnswer((_) async => left(GetShoppingListFailure('test')));

    var result = await usecase(userId);
    expect(
        result.leftMap((l) => l is GetShoppingListFailure), const Left(true));
  });
}
