import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_market/app/modules/shopping_list/domain/errors/errors.dart';
import 'package:easy_market/app/modules/shopping_list/infra/repositories/shopping_list_repository_impl.dart';
import 'package:mockito/mockito.dart';

import '../../../../test_helper.dart';
import '../../mock_shopping_list_test.dart';
import '../../mock_shopping_list_test.mocks.dart';

void main() {
  final datasource = MockShoppingListDatasource();
  final repository = ShoppingListRepositoryImpl(datasource);

  TestHelper.loadAppLocalizations();

  group('Get ShoppingList', () {
    test('Should return list of ShoppingList', () async {
      final lists = shoppingLists;
      when(datasource.getShoppingLists(userId)).thenAnswer((_) async => lists);

      final result = await repository.getShoppingLists(userId);
      expect(result, Right(lists));
    });

    test('Should listen to the ShoppingList stream', () async {
      final mockStream = MockStreamShoppingLists();
      when(datasource.listenShoppingLists(userId))
          .thenAnswer((_) => mockStream);
      when(mockStream.first).thenAnswer((_) => Future.value(shoppingLists));

      final result =
          (repository.listenShoppingLists(userId)).fold((l) => null, (r) => r);
      expect(result, isNotNull);
      expect(await result!.first, isNotEmpty);
    });
  });

  group('Create ShoppingList', () {
    test('Should return ShoppingList', () async {
      final list = shoppingList;
      when(datasource.createShoppingList(any)).thenAnswer((_) async => list);

      final result = await repository.createShoppingList(list);
      expect(result, Right(list));
    });

    test(
        'Should throw CreateShoppingListFailure when there are any errors to save',
        () async {
      when(datasource.createShoppingList(any))
          .thenThrow((_) async => Exception());

      final result = await repository.createShoppingList(shoppingList);
      expect(result.leftMap((l) => l is CreateShoppingListFailure),
          const Left(true));
    });
  });

  group('Edit ShoppingList', () {
    test('Should return  Unit', () async {
      when(datasource.updateShoppingList(any)).thenAnswer((_) async => Unit);

      final result = await repository.updateShoppingList(shoppingList);
      expect(result, const Right(unit));
    });

    test(
        'Should throw UpdateShoppingListFailure when there are any errors to save',
        () async {
      when(datasource.updateShoppingList(any))
          .thenThrow((_) async => Exception());

      final result = await repository.updateShoppingList(shoppingList);
      expect(result.leftMap((l) => l is UpdateShoppingListFailure),
          const Left(true));
    });
  });

  group('Delete ShoppingList', () {
    test('Should return Unit', () async {
      when(datasource.deleteShoppingList(any))
          .thenAnswer((_) async => shoppingList);

      final result = await repository.deleteShoppingList(shoppingList);
      expect(result, const Right(unit));
    });

    test(
        'Should throw DeleteShoppingListFailure when there are any errors to save',
        () async {
      when(datasource.deleteShoppingList(any))
          .thenThrow((_) async => Exception());

      final result = await repository.deleteShoppingList(shoppingList);
      expect(result.leftMap((l) => l is DeleteShoppingListFailure),
          const Left(true));
    });
  });

  group('Add Item', () {
    test('Should add and return Item', () async {
      final mockItem = item;
      when(datasource.addItemToList(any)).thenAnswer((_) async => mockItem);

      final result = await repository.addItemToList(item);
      expect(result, Right(mockItem));
    });

    test('Should throw AddItemFailure when there are any errors to save',
        () async {
      when(datasource.addItemToList(any)).thenThrow((_) async => Exception());

      final result = await repository.addItemToList(item);
      expect(result.leftMap((l) => l is AddItemFailure), const Left(true));
    });
  });

  group('Get Item', () {
    test('Should get Items', () async {
      final mockItems = items;
      when(datasource.getItemsFromList(any)).thenAnswer((_) async => mockItems);

      final result = await repository.getItemsFromList('id');
      expect(result, Right(mockItems));
    });

    test('Should throw GetItemsFailure when there are any errors to get',
        () async {
      when(datasource.getItemsFromList(any))
          .thenThrow((_) async => Exception());

      final result = await repository.getItemsFromList('id');
      expect(result.leftMap((l) => l is GetItemsFailure), const Left(true));
    });
  });

  group('Listen Items', () {
    test('Should listen to the items stream', () async {
      final mockStream = MockStreamItem();
      when(datasource.listenItemsFromList(any)).thenAnswer((_) => mockStream);
      when(mockStream.first).thenAnswer((_) => Future.value(items));

      final result =
          (repository.listenItemsFromList('id')).fold((l) => null, (r) => r);
      expect(result, isNotNull);
      expect(await result!.first, isNotEmpty);
    });
  });

  group('Update Item', () {
    test('Should update Item', () async {
      when(datasource.updateItemInList(any)).thenAnswer((_) async => unit);

      final result = await repository.updateItemInList(item);
      expect(result, const Right(unit));
    });

    test('Should throw UpdateItemFailure when there are any errors to save',
        () async {
      when(datasource.updateItemInList(any))
          .thenThrow((_) async => Exception());

      final result = await repository.updateItemInList(item);
      expect(result.leftMap((l) => l is UpdateItemFailure), const Left(true));
    });
  });

  group('Delete Item', () {
    test('Should delete Item', () async {
      when(datasource.deleteItemFromList(any)).thenAnswer((_) async => unit);

      final result = await repository.deleteItemFromList(item);
      expect(result, const Right(unit));
    });

    test('Should throw DeleteItemFailure when there are any errors to delete',
        () async {
      when(datasource.deleteItemFromList(any))
          .thenThrow((_) async => Exception());

      final result = await repository.deleteItemFromList(item);
      expect(result.leftMap((l) => l is DeleteItemFailure), const Left(true));
    });
  });

  group('Reorderd Item', () {
    test('Should reorderd Item', () async {
      when(datasource.reorderItemInList(
        any,
        next: anyNamed('next'),
        prev: anyNamed('prev'),
      )).thenAnswer((_) async => unit);

      final result = await repository.reorderItemInList(item, prev: item);
      expect(result, const Right(unit));
    });

    test('Should throw ReorderItemFailure when there are any errors to reorder',
        () async {
      when(datasource.reorderItemInList(
        any,
        next: anyNamed('next'),
        prev: anyNamed('prev'),
      )).thenThrow((_) async => Exception());

      final result = await repository.reorderItemInList(item, prev: item);
      expect(result.leftMap((l) => l is ReorderItemFailure), const Left(true));
    });
  });

  group('Check Item', () {
    test('Should check Item', () async {
      when(datasource.checkItemInList(any, any, any))
          .thenAnswer((_) async => unit);

      final result =
          await repository.checkItemInList('shoppingListId', 'itemId', true);
      expect(result, const Right(unit));
    });

    test('Should throw CheckItemFailure when there are any errors to check',
        () async {
      when(datasource.checkItemInList(any, any, any))
          .thenThrow((_) async => Exception());

      final result =
          await repository.checkItemInList('shoppingListId', 'itemId', true);
      expect(result.leftMap((l) => l is CheckItemFailure), const Left(true));
    });
  });
}
