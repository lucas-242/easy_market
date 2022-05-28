import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:market_lists/app/modules/grocery/domain/errors/errors.dart';
import 'package:market_lists/app/modules/grocery/domain/usecases/get_grocery_lists.dart';
import 'package:mockito/mockito.dart';

import '../../mock_groceries_test.dart' as mock;
import '../../mock_groceries_test.mocks.dart';

void main() {
  final repository = MockGroceryRepositoryTest();
  final usecase = GetGroceryListsImpl(repository);

  test('Should return a List of GroceryList', () async {
    var groceryLists = mock.groceryLists;
    when(repository.getGroceryLists())
        .thenAnswer((_) async => right(groceryLists));

    var result = (await usecase()).fold((l) => null, (r) => r);
    expect(result, isNotNull);
    expect(result, isNotEmpty);
  });

  test('Should throw GroceryListFailure when there are any errors to save',
      () async {
    when(repository.getGroceryLists())
        .thenAnswer((_) async => left(GroceryListFailure()));

    var result = await usecase();
    expect(result.leftMap((l) => l is GroceryListFailure), const Left(true));
  });
}
