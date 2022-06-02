import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:market_lists/app/modules/shopping_list/domain/errors/errors.dart';
import 'package:market_lists/app/modules/shopping_list/infra/repositories/shopping_list_repository_impl.dart';
import 'package:mockito/mockito.dart';

import '../../mock_shopping_list_test.dart' as mock;
import '../../mock_shopping_list_test.mocks.dart';

void main() {
  final datasource = MockShoppingListDatasourceTest();
  final repository = ShoppingListRepositoryImpl(datasource);

  group('Get ShoppingList', () {
    test('Should return list of ShoppingList', () async {
      var shoppingLists = mock.shoppingListModelList;
      when(datasource.getShoppingLists())
          .thenAnswer((_) async => shoppingLists);

      var result = await repository.getShoppingLists();
      expect(result, Right(shoppingLists));
    });

    test('Should listen to the ShoppingList stream', () async {
      var mockStream = MockStreamShoppingListsTest();
      when(datasource.listenShoppingLists()).thenAnswer((_) => mockStream);
      when(mockStream.first)
          .thenAnswer((_) => Future.value(mock.shoppingListModelList));

      var result =
          (repository.listenShoppingLists()).fold((l) => null, (r) => r);
      expect(result, isNotNull);
      expect(await result!.first, isNotEmpty);
    });
  });

  group('Create ShoppingList', () {
    test('Should return ShoppingList', () async {
      var shoppingList = mock.shoppingListModelToUpdate;
      when(datasource.createShoppingList(any))
          .thenAnswer((_) async => shoppingList);

      var result =
          await repository.createShoppingList(mock.shoppingListToCreate);
      expect(result, Right(shoppingList));
    });

    test('Should throw ShoppingListFailure when there are any errors to save',
        () async {
      when(datasource.createShoppingList(any))
          .thenThrow((_) async => Exception());

      var result =
          await repository.createShoppingList(mock.shoppingListToCreate);
      expect(result.leftMap((l) => l is ShoppingListFailure), const Left(true));
    });
  });

  group('Edit ShoppingList', () {
    test('Should return  Unit', () async {
      var shoppingList = mock.shoppingListToUpdate;
      when(datasource.updateShoppingList(any)).thenAnswer((_) async => Unit);

      var result = await repository.updateShoppingList(shoppingList);
      expect(result, const Right(unit));
    });

    test('Should throw ShoppingListFailure when there are any errors to save',
        () async {
      when(datasource.updateShoppingList(any))
          .thenThrow((_) async => Exception());

      var result =
          await repository.updateShoppingList(mock.shoppingListToCreate);
      expect(result.leftMap((l) => l is ShoppingListFailure), const Left(true));
    });
  });

  group('Delete ShoppingList', () {
    test('Should return Unit', () async {
      var shoppingList = mock.shoppingListToUpdate;
      when(datasource.deleteShoppingList(any))
          .thenAnswer((_) async => shoppingList);

      var result = await repository.deleteShoppingList(shoppingList);
      expect(result, const Right(unit));
    });

    test('Should throw ShoppingListFailure when there are any errors to save',
        () async {
      when(datasource.deleteShoppingList(any))
          .thenThrow((_) async => Exception());

      var result =
          await repository.deleteShoppingList(mock.shoppingListToCreate);
      expect(result.leftMap((l) => l is ShoppingListFailure), const Left(true));
    });
  });
}
