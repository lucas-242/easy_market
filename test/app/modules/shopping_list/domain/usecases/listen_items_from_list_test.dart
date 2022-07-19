import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_market/app/modules/shopping_list/domain/errors/errors.dart';
import 'package:easy_market/app/modules/shopping_list/domain/usecases/listen_items_from_list.dart';
import 'package:mockito/mockito.dart';

import '../../mock_shopping_list_test.dart' as mock;
import '../../mock_shopping_list_test.mocks.dart';

void main() {
  final repository = MockItemRepositoryTest();
  final usecase = ListenItemsFromListImpl(repository);
  var mockStream = MockStreamItemTest();

  when(mockStream.first).thenAnswer((_) => Future.value(mock.itemModelList));

  test('Should return a List of Item', () async {
    when(repository.listenItemsFromList(any))
        .thenAnswer((_) => right(mockStream));

    var result = (usecase('id')).fold((l) => null, (r) => r);
    expect(result, isNotNull);
    expect(await result!.first, isNotEmpty);
  });

  test('Should throw ShoppingListFailure when there are any errors to listen',
      () async {
    when(repository.listenItemsFromList(any))
        .thenAnswer((_) => left(ShoppingListFailure()));

    var result = usecase('id');
    expect(result.leftMap((l) => l is ShoppingListFailure), const Left(true));
  });
}
