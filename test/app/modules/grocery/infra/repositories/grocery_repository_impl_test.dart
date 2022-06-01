import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:market_lists/app/modules/grocery/domain/errors/errors.dart';
import 'package:market_lists/app/modules/grocery/infra/repositories/grocery_repository_impl.dart';
import 'package:mockito/mockito.dart';

import '../../mock_groceries_test.dart' as mock;
import '../../mock_groceries_test.mocks.dart';

void main() {
  final datasource = MockGroceryDatasourceTest();
  final repository = GroceryRepositoryImpl(datasource);

  group('Get GroceryList', () {
    test('Should return list of GroceryList', () async {
      var groceryLists = mock.groceryListModelList;
      when(datasource.getGroceryLists()).thenAnswer((_) async => groceryLists);

      var result = await repository.getGroceryLists();
      expect(result, Right(groceryLists));
    });

    test('Should listen to the GroceryList stream', () async {
      var mockStream = MockStreamGroceryListsTest();
      when(datasource.listenGroceryLists()).thenAnswer((_) => mockStream);
      when(mockStream.first)
          .thenAnswer((_) => Future.value(mock.groceryListModelList));

      var result =
          (repository.listenGroceryLists()).fold((l) => null, (r) => r);
      expect(result, isNotNull);
      expect(await result!.first, isNotEmpty);
    });
  });

  group('Create GroceryList', () {
    test('Should return GroceryList', () async {
      var groceryList = mock.groceryListModelToUpdate;
      when(datasource.createGroceryList(any))
          .thenAnswer((_) async => groceryList);

      var result = await repository.createGroceryList(mock.groceryListToCreate);
      expect(result, Right(groceryList));
    });

    test('Should throw GroceryListFailure when there are any errors to save',
        () async {
      when(datasource.createGroceryList(any))
          .thenThrow((_) async => Exception());

      var result = await repository.createGroceryList(mock.groceryListToCreate);
      expect(result.leftMap((l) => l is GroceryListFailure), const Left(true));
    });
  });

  group('Edit GroceryList', () {
    test('Should return  Unit', () async {
      var groceryList = mock.groceryListToUpdate;
      when(datasource.updateGroceryList(any)).thenAnswer((_) async => Unit);

      var result = await repository.updateGroceryList(groceryList);
      expect(result, const Right(unit));
    });

    test('Should throw GroceryListFailure when there are any errors to save',
        () async {
      when(datasource.updateGroceryList(any))
          .thenThrow((_) async => Exception());

      var result = await repository.updateGroceryList(mock.groceryListToCreate);
      expect(result.leftMap((l) => l is GroceryListFailure), const Left(true));
    });
  });

  group('Delete GroceryList', () {
    test('Should return Unit', () async {
      var groceryList = mock.groceryListToUpdate;
      when(datasource.deleteGroceryList(any))
          .thenAnswer((_) async => groceryList);

      var result = await repository.deleteGroceryList(groceryList);
      expect(result, const Right(unit));
    });

    test('Should throw GroceryListFailure when there are any errors to save',
        () async {
      when(datasource.deleteGroceryList(any))
          .thenThrow((_) async => Exception());

      var result = await repository.deleteGroceryList(mock.groceryListToCreate);
      expect(result.leftMap((l) => l is GroceryListFailure), const Left(true));
    });
  });

  group('Add Grocery', () {
    test('Should add and return Grocery', () async {
      var grocery = mock.groceryModelToAdd;
      when(datasource.addGroceryToList(any)).thenAnswer((_) async => grocery);

      var result = await repository.addGroceryToList(mock.groceryToAdd);
      expect(result, Right(grocery));
    });

    test('Should throw GroceryListFailure when there are any errors to save',
        () async {
      when(datasource.addGroceryToList(any))
          .thenThrow((_) async => Exception());

      var result = await repository.addGroceryToList(mock.groceryToAdd);
      expect(result.leftMap((l) => l is GroceryListFailure), const Left(true));
    });
  });
}
