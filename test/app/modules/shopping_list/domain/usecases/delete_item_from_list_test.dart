import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_market/app/modules/shopping_list/domain/errors/errors.dart';
import 'package:easy_market/app/modules/shopping_list/domain/usecases/delete_item_from_list.dart';
import 'package:mockito/mockito.dart';

import '../../mock_shopping_list_test.dart' as mock;
import '../../mock_shopping_list_test.mocks.dart';

void main() {
  final repository = MockItemRepositoryTest();
  final usecase = DeleteItemFromListImpl(repository);

  test('Should delete an Item', () async {
    when(repository.deleteItemFromList(any))
        .thenAnswer((_) async => right(unit));

    var result = await usecase(mock.itemToUpdate);
    expect(result, const Right(unit));
  });

  test('Should throw InvalidShoppingList when the item is invalid', () async {
    var result = await usecase(mock.itemToAdd);
    expect(result.leftMap((l) => l is InvalidShoppingList), const Left(true));
  });

  test('Should throw ShoppingListFail when the are any errors to delete',
      () async {
    when(repository.deleteItemFromList(any))
        .thenAnswer((_) async => left(ShoppingListFailure()));

    var result = await usecase(mock.itemToUpdate);
    expect(result.leftMap((l) => l is ShoppingListFailure), const Left(true));
  });
}
