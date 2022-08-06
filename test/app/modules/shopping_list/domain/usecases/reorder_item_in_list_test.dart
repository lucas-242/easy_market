import 'package:dartz/dartz.dart';
import 'package:easy_market/app/modules/shopping_list/domain/usecases/reorder_items_in_list.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_market/app/modules/shopping_list/domain/errors/errors.dart';
import 'package:mockito/mockito.dart';

import '../../../../test_helper.dart';
import '../../mock_shopping_list_test.dart';
import '../../mock_shopping_list_test.mocks.dart';

void main() {
  final repository = MockShoppingListRepository();
  final usecase = ReorderItemInListImpl(repository);
  TestHelper.loadAppLocalizations();

  test('Should reorder item', () async {
    when(repository.reorderItemInList(
      any,
      next: anyNamed('next'),
      prev: anyNamed('prev'),
    )).thenAnswer((_) async => right(unit));

    final result = await usecase(item, prev: item);
    expect(result, const Right(unit));
  });

  test('Should throw ReorderItemFailure when prev and next are null', () async {
    final result = await usecase(item);
    expect(result.leftMap((l) => l is ReorderItemFailure), const Left(true));
  });

  test('Should throw ReorderItemFailure when there are any errors to reorder',
      () async {
    when(repository.reorderItemInList(any))
        .thenAnswer((_) async => left(ReorderItemFailure('test')));

    final result = await usecase(item);
    expect(result.leftMap((l) => l is ReorderItemFailure), const Left(true));
  });
}
