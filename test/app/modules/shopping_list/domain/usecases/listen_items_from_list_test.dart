import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_market/app/modules/shopping_list/domain/errors/errors.dart';
import 'package:easy_market/app/modules/shopping_list/domain/usecases/listen_items_from_list.dart';
import 'package:mockito/mockito.dart';

import '../../mock_shopping_list_test.dart';
import '../../mock_shopping_list_test.mocks.dart';

void main() {
  final repository = MockShoppingListRepository();
  final usecase = ListenItemsFromListImpl(repository);
  final mockStream = MockStreamItem();

  when(mockStream.first).thenAnswer((_) => Future.value(items));

  test('Should return a List of Item', () async {
    when(repository.listenItemsFromList(any))
        .thenAnswer((_) => right(mockStream));

    final result = (usecase('id')).fold((l) => null, (r) => r);
    expect(result, isNotNull);
    expect(await result!.first, isNotEmpty);
  });

  test('Should throw GetItemsFailure when there are any errors to listen',
      () async {
    when(repository.listenItemsFromList(any))
        .thenAnswer((_) => left(GetItemsFailure('test')));

    final result = usecase('id');
    expect(result.leftMap((l) => l is GetItemsFailure), const Left(true));
  });
}
