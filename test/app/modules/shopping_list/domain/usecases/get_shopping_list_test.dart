import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_market/app/modules/shopping_list/domain/errors/errors.dart';
import 'package:easy_market/app/modules/shopping_list/domain/usecases/get_shopping_lists.dart';
import 'package:mockito/mockito.dart';

import '../../mock_shopping_list_test.dart' as mock;
import '../../mock_shopping_list_test.mocks.dart';

void main() {
  final repository = MockShoppingListRepositoryTest();
  final usecase = GetShoppingListsImpl(repository);

  test('Should return a List of ShoppingList', () async {
    var shoppingLists = mock.shoppingLists;
    when(repository.getShoppingLists())
        .thenAnswer((_) async => right(shoppingLists));

    var result = (await usecase()).fold((l) => null, (r) => r);
    expect(result, isNotNull);
    expect(result, isNotEmpty);
  });

  test('Should throw ShoppingListFailure', () async {
    when(repository.getShoppingLists())
        .thenAnswer((_) async => left(ShoppingListFailure()));

    var result = await usecase();
    expect(result.leftMap((l) => l is ShoppingListFailure), const Left(true));
  });
}
