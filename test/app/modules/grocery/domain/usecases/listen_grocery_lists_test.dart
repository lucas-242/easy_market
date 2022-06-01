import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:market_lists/app/modules/grocery/domain/errors/errors.dart';
import 'package:market_lists/app/modules/grocery/domain/usecases/listen_grocery_lists.dart';
import 'package:mockito/mockito.dart';

import '../../mock_groceries_test.dart' as mock;
import '../../mock_groceries_test.mocks.dart';

void main() {
  final repository = MockGroceryRepositoryTest();
  final usecase = ListenGroceryListsImpl(repository);
  var mockStream = MockStreamGroceryListsTest();

  when(mockStream.first)
      .thenAnswer((_) => Future.value(mock.groceryListModelList));

  test('Should return a List of GroceryList', () async {
    when(repository.listenGroceryLists()).thenAnswer((_) => right(mockStream));

    var result = (usecase()).fold((l) => null, (r) => r);
    expect(result, isNotNull);
    expect(await result!.first, isNotEmpty);
  });

  test('Should throw GroceryListFailure when there are any errors to save',
      () async {
    when(repository.listenGroceryLists())
        .thenAnswer((_) => left(GroceryListFailure()));

    var result = usecase();
    expect(result.leftMap((l) => l is GroceryListFailure), const Left(true));
  });
}
