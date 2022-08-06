import 'package:dartz/dartz.dart';
import 'package:easy_market/app/modules/shopping_list/domain/usecases/check_item_in_list.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_market/app/modules/shopping_list/domain/errors/errors.dart';
import 'package:mockito/mockito.dart';

import '../../../../test_helper.dart';
import '../../mock_shopping_list_test.mocks.dart';

void main() {
  final repository = MockShoppingListRepository();
  final usecase = CheckItemInListImpl(repository);
  TestHelper.loadAppLocalizations();

  test('Should update item', () async {
    when(repository.checkItemInList(any, any, any))
        .thenAnswer((_) async => right(unit));

    final result = await usecase('shoppingListId', 'itemId', true);
    expect(result, const Right(unit));
  });

  test('Should throw CheckItemFailure when params are empty', () async {
    final result = await usecase('', 'itemId', true);
    expect(result.leftMap((l) => l is CheckItemFailure), const Left(true));
  });

  test('Should throw CheckItemFailure when there are any errors to save',
      () async {
    when(repository.checkItemInList(any, any, any))
        .thenAnswer((_) async => left(CheckItemFailure('test')));

    final result = await usecase('shoppingListId', 'itemId', true);
    expect(result.leftMap((l) => l is CheckItemFailure), const Left(true));
  });
}
