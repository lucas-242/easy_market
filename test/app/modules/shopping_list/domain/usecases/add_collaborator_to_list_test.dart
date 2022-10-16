import 'package:dartz/dartz.dart';
import 'package:easy_market/app/modules/shopping_list/domain/usecases/add_collaborator_to_list.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_market/app/modules/shopping_list/domain/errors/errors.dart';
import 'package:mockito/mockito.dart';

import '../../../../test_helper.dart';
import '../../mock_shopping_list_test.dart';
import '../../mock_shopping_list_test.mocks.dart';

void main() {
  final repository = MockShoppingListRepository();
  final usecase = AddCollaboratorToListImpl(repository);
  TestHelper.loadAppLocalizations();

  test('Should add collaborator', () async {
    when(repository.addCollaboratorToList(any, any))
        .thenAnswer((_) async => right(unit));

    final result = await usecase(shoppingList.id, 'test@email.com');
    expect(result, const Right(unit));
  });

  test('Should throw AddCollaboratorFailure when the email is invalid',
      () async {
    final result = await usecase(shoppingList.id, 'test@email');
    expect(
        result.leftMap((l) => l is AddCollaboratorFailure), const Left(true));
  });

  test('Should throw AddCollaboratorFailure when there are any errors to save',
      () async {
    when(repository.addCollaboratorToList(any, any))
        .thenAnswer((_) async => left(AddCollaboratorFailure('test')));

    final result = await usecase(shoppingList.id, 'test@email.com');
    expect(
        result.leftMap((l) => l is AddCollaboratorFailure), const Left(true));
  });
}
