import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_market/app/modules/shopping_list/domain/errors/errors.dart';
import 'package:easy_market/app/modules/shopping_list/domain/usecases/add_item_to_list.dart';
import 'package:mockito/mockito.dart';

import '../../../../test_helper.dart';
import '../../mock_shopping_list_test.dart';
import '../../mock_shopping_list_test.mocks.dart';

void main() {
  final repository = MockShoppingListRepository();
  final usecase = AddItemToListImpl(repository);
  TestHelper.loadAppLocalizations();

  test('Should return an Item', () async {
    final mockItem = item;
    when(repository.addItemToList(any))
        .thenAnswer((_) async => right(mockItem));

    final result = await usecase(mockItem);
    expect(result, Right(mockItem));
  });

  test('Should throw InvalidShoppingList when the item is invalid', () async {
    final mockItem = item.copyWith(name: '');
    final result = await usecase(mockItem);
    expect(result.leftMap((l) => l is InvalidShoppingList), const Left(true));
  });

  test('Should throw GetShoppingListFailure when there are any errors to save',
      () async {
    when(repository.addItemToList(any))
        .thenAnswer((_) async => left(GetShoppingListFailure('test')));

    final result = await usecase(item);
    expect(
        result.leftMap((l) => l is GetShoppingListFailure), const Left(true));
  });
}
