import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:market_lists/app/grocery/domain/entities/grocery_list.dart';
import 'package:market_lists/app/grocery/domain/errors/errors.dart';
import 'package:market_lists/app/grocery/domain/repositories/grocery_repository.dart';
import 'package:market_lists/app/grocery/domain/usecases/delete_grocery_list.dart';
import 'package:mockito/mockito.dart';

import '../../mock_groceries_test.mocks.dart';

void main() {
  final groceryRepository = MockGroceryRepositoryTest();
  final usecase = DeleteGroceryListImpl(groceryRepository);

  final groceryListMock = GroceryList(id: '123', name: 'name');

  test('Should delete GroceryList', () async {
    when(groceryRepository.deleteGroceryList(any))
        .thenAnswer((_) async => right(unit));

    var result = await usecase(groceryListMock);
    expect(result, const Right(unit));
  });

  test('Should throw InvalidGroceryList when the list is invalid', () async {
    final groceryList = GroceryList(id: '', name: 'name');
    var result = await usecase(groceryList);
    expect(result.leftMap((l) => l is InvalidGroceryList), const Left(true));
  });

  test('Should throw GroceryListFail when the are any errors to save',
      () async {
    when(groceryRepository.deleteGroceryList(any))
        .thenAnswer((_) async => left(GroceryListFailure()));

    var result = await usecase(groceryListMock);
    expect(result.leftMap((l) => l is GroceryListFailure), const Left(true));
  });
}
