import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_market/app/modules/shopping_list/domain/errors/errors.dart';
import 'package:easy_market/app/modules/shopping_list/domain/usecases/update_item_in_list.dart';
import 'package:mockito/mockito.dart';

import '../../mock_shopping_list_test.dart';
import '../../mock_shopping_list_test.mocks.dart';

void main() {
  final repository = MockShoppingListRepository();
  final usecase = UpdateItemInListImpl(repository);

  test('Should update item', () async {
    when(repository.updateItemInList(any)).thenAnswer((_) async => right(unit));

    final result = await usecase(item);
    expect(result, const Right(unit));
  });

  test('Should throw InvalidShoppingList when the item is invalid', () async {
    final mockItem = item.copyWith(name: '');
    final result = await usecase(mockItem);
    expect(result.leftMap((l) => l is InvalidShoppingList), const Left(true));
  });

  test('Should throw UpdateItemFailure when there are any errors to save',
      () async {
    when(repository.updateItemInList(any))
        .thenAnswer((_) async => left(UpdateItemFailure('test')));

    final result = await usecase(item);
    expect(result.leftMap((l) => l is UpdateItemFailure), const Left(true));
  });
}
