import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:market_lists/app/modules/shopping_list/domain/entities/item.dart';
import 'package:market_lists/app/modules/shopping_list/domain/errors/errors.dart';
import 'package:market_lists/app/modules/shopping_list/domain/usecases/add_item_to_list.dart';
import 'package:mockito/mockito.dart';

import '../../mock_shopping_list_test.dart' as mock;
import '../../mock_shopping_list_test.mocks.dart';

void main() {
  final repository = MockItemRepositoryTest();
  final usecase = AddItemToListImpl(repository);

  test('Should return an Item', () async {
    var item = mock.itemToAdd;
    when(repository.addItemToList(any)).thenAnswer((_) async => right(item));

    var result = await usecase(item);
    expect(result, Right(item));
  });

  test('Should throw InvalidShoppingList when the item is invalid', () async {
    var item = const Item(
      name: 'product1',
      quantity: 0,
      shoppingListId: '',
    );

    var result = await usecase(item);
    expect(result.leftMap((l) => l is InvalidShoppingList), const Left(true));
  });

  test('Should throw ShoppingListFailure when there are any errors to save',
      () async {
    when(repository.addItemToList(any))
        .thenAnswer((_) async => left(ShoppingListFailure()));

    var result = await usecase(mock.itemToAdd);
    expect(result.leftMap((l) => l is ShoppingListFailure), const Left(true));
  });
}
