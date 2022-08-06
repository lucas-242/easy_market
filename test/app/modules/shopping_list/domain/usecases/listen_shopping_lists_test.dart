import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_market/app/modules/shopping_list/domain/errors/errors.dart';
import 'package:easy_market/app/modules/shopping_list/domain/usecases/listen_shopping_lists.dart';
import 'package:mockito/mockito.dart';

import '../../../../test_helper.dart';
import '../../mock_shopping_list_test.dart';
import '../../mock_shopping_list_test.mocks.dart';

void main() {
  final repository = MockShoppingListRepository();
  final usecase = ListenShoppingListsImpl(repository);
  final mockStream = MockStreamShoppingLists();
  const userId = 'userId';
  TestHelper.loadAppLocalizations();

  when(mockStream.first).thenAnswer((_) => Future.value(shoppingLists));

  test('Should return a List of ShoppingList', () async {
    when(repository.listenShoppingLists(userId))
        .thenAnswer((_) => right(mockStream));

    final result = (usecase(userId)).fold((l) => null, (r) => r);
    expect(result, isNotNull);
    expect(await result!.first, isNotEmpty);
  });

  test(
      'Should throw GetShoppingListFailure when there are any errors to listen',
      () async {
    when(repository.listenShoppingLists(userId))
        .thenAnswer((_) => left(GetShoppingListFailure('')));

    final result = usecase(userId);
    expect(
        result.leftMap((l) => l is GetShoppingListFailure), const Left(true));
  });
}
