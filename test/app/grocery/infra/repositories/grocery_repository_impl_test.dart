import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:market_lists/app/grocery/domain/errors/errors.dart';
import 'package:market_lists/app/grocery/infra/repositories/grocery_repository_impl.dart';
import 'package:mockito/mockito.dart';

import '../../mock_groceries_test.dart' as mock;
import '../../mock_groceries_test.mocks.dart';

void main() {
  final datasource = MockGroceryDatasourceTest();
  final repository = GroceryRepositoryImpl(datasource);

  test('Should return GroceryList', () async {
    var groceryList = mock.groceryListToUpdate;
    when(datasource.createGroceryList(any))
        .thenAnswer((_) async => groceryList);

    var result = await repository.createGroceryList(mock.groceryListToCreate);
    expect(result, Right(groceryList));
  });

  test('Should throw GroceryListFailure when there are any errors to save',
      () async {
    when(datasource.createGroceryList(any)).thenThrow((_) async => Exception());

    var result = await repository.createGroceryList(mock.groceryListToCreate);
    expect(result.leftMap((l) => l is GroceryListFailure), const Left(true));
  });
}
