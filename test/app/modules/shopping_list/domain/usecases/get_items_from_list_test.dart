import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_market/app/modules/shopping_list/domain/errors/errors.dart';
import 'package:easy_market/app/modules/shopping_list/domain/usecases/get_items_from_list.dart';
import 'package:mockito/mockito.dart';

import '../../mock_shopping_list_test.dart';
import '../../mock_shopping_list_test.mocks.dart';

void main() {
  final repository = MockShoppingListRepository();
  final usecase = GetItemsFromListImpl(repository);

  test('Should return a Item', () async {
    when(repository.getItemsFromList(any))
        .thenAnswer((_) async => right(items));

    final result = (await usecase('id')).fold((l) => null, (r) => r);
    expect(result, isNotNull);
    expect(result, isNotEmpty);
  });

  test('Should throw GetItemsFailure when there are any errors to save',
      () async {
    when(repository.getItemsFromList(any))
        .thenAnswer((_) async => left(GetItemsFailure('test')));

    final result = await usecase('id');
    expect(result.leftMap((l) => l is GetItemsFailure), const Left(true));
  });
}
