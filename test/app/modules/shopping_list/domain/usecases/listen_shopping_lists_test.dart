import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:market_lists/app/modules/shopping_list/domain/errors/errors.dart';
import 'package:market_lists/app/modules/shopping_list/domain/usecases/listen_shopping_lists.dart';
import 'package:mockito/mockito.dart';

import '../../mock_shopping_list_test.dart' as mock;
import '../../mock_shopping_list_test.mocks.dart';

void main() {
  final repository = MockShoppingListRepositoryTest();
  final usecase = ListenShoppingListsImpl(repository);
  var mockStream = MockStreamShoppingListsTest();

  when(mockStream.first)
      .thenAnswer((_) => Future.value(mock.shoppingListModelList));

  test('Should return a List of ShoppingList', () async {
    when(repository.listenShoppingLists()).thenAnswer((_) => right(mockStream));

    var result = (usecase()).fold((l) => null, (r) => r);
    expect(result, isNotNull);
    expect(await result!.first, isNotEmpty);
  });

  test('Should throw ShoppingListFailure when there are any errors to listen',
      () async {
    when(repository.listenShoppingLists())
        .thenAnswer((_) => left(ShoppingListFailure()));

    var result = usecase();
    expect(result.leftMap((l) => l is ShoppingListFailure), const Left(true));
  });
}
