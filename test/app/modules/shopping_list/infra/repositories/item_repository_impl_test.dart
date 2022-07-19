import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_market/app/modules/shopping_list/domain/errors/errors.dart';
import 'package:easy_market/app/modules/shopping_list/infra/repositories/item_repository_impl.dart';
import 'package:mockito/mockito.dart';

import '../../mock_shopping_list_test.dart' as mock;
import '../../mock_shopping_list_test.mocks.dart';

void main() {
  final datasource = MockShoppingListDatasourceTest();
  final repository = ItemRepositoryImpl(datasource);

  group('Add Item', () {
    test('Should add and return Item', () async {
      var item = mock.itemModelToAdd;
      when(datasource.addItemToList(any)).thenAnswer((_) async => item);

      var result = await repository.addItemToList(mock.itemToAdd);
      expect(result, Right(item));
    });

    test('Should throw ShoppingListFailure when there are any errors to save',
        () async {
      when(datasource.addItemToList(any)).thenThrow((_) async => Exception());

      var result = await repository.addItemToList(mock.itemToAdd);
      expect(result.leftMap((l) => l is ShoppingListFailure), const Left(true));
    });
  });

  group('Get Item', () {
    test('Should get Items', () async {
      var items = mock.itemModelList;
      when(datasource.getItemsFromList(any)).thenAnswer((_) async => items);

      var result = await repository.getItemsFromList('id');
      expect(result, Right(items));
    });

    test('Should throw ShoppingListFailure when there are any errors to get',
        () async {
      when(datasource.getItemsFromList(any))
          .thenThrow((_) async => Exception());

      var result = await repository.getItemsFromList('id');
      expect(result.leftMap((l) => l is ShoppingListFailure), const Left(true));
    });
  });

  group('Listen Items', () {
    test('Should listen to the items stream', () async {
      var mockStream = MockStreamItemTest();
      when(datasource.listenItemsFromList(any)).thenAnswer((_) => mockStream);
      when(mockStream.first)
          .thenAnswer((_) => Future.value(mock.itemModelList));

      var result =
          (repository.listenItemsFromList('id')).fold((l) => null, (r) => r);
      expect(result, isNotNull);
      expect(await result!.first, isNotEmpty);
    });
  });

  group('Update Item', () {
    test('Should update Item', () async {
      when(datasource.updateItemInList(any)).thenAnswer((_) async => unit);

      var result = await repository.updateItemInList(mock.itemToUpdate);
      expect(result, const Right(unit));
    });

    test('Should throw ShoppingListFailure when there are any errors to save',
        () async {
      when(datasource.updateItemInList(any))
          .thenThrow((_) async => Exception());

      var result = await repository.addItemToList(mock.itemToUpdate);
      expect(result.leftMap((l) => l is ShoppingListFailure), const Left(true));
    });
  });

  group('Delete Item', () {
    test('Should delete Item', () async {
      when(datasource.deleteItemFromList(any)).thenAnswer((_) async => unit);

      var result = await repository.deleteItemFromList(mock.itemToUpdate);
      expect(result, const Right(unit));
    });

    test('Should throw ShoppingListFailure when there are any errors to delete',
        () async {
      when(datasource.deleteItemFromList(any))
          .thenThrow((_) async => Exception());

      var result = await repository.deleteItemFromList(mock.itemToUpdate);
      expect(result.leftMap((l) => l is ShoppingListFailure), const Left(true));
    });
  });
}
