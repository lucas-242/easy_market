import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_market/app/modules/shopping_list/domain/errors/errors.dart';
import 'package:easy_market/app/modules/shopping_list/domain/usecases/delete_item_from_list.dart';
import 'package:mockito/mockito.dart';

import '../../../../test_helper.dart';
import '../../mock_shopping_list_test.dart';
import '../../mock_shopping_list_test.mocks.dart';

void main() {
  final repository = MockShoppingListRepository();
  final usecase = DeleteItemFromListImpl(repository);
  TestHelper.loadAppLocalizations();

  test('Should delete an Item', () async {
    when(repository.deleteItemFromList(any))
        .thenAnswer((_) async => right(unit));
    final result = await usecase(item);
    expect(result, const Right(unit));
  });

  test('Should throw InvalidShoppingList when the item is invalid', () async {
    final mockItem = item.copyWith(id: '');
    final result = await usecase(mockItem);
    expect(result.leftMap((l) => l is InvalidShoppingList), const Left(true));
  });

  test('Should throw DeleteItemFailure when the are any errors to delete',
      () async {
    when(repository.deleteItemFromList(any))
        .thenAnswer((_) async => left(DeleteItemFailure('test')));

    final result = await usecase(item);
    expect(result.leftMap((l) => l is DeleteItemFailure), const Left(true));
  });
}
