import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/errors/errors.dart';
import '../../../../core/l10n/generated/l10n.dart';
import '../../shopping_list.dart';
import '../errors/errors.dart';

part 'check_item_in_list.g.dart';

abstract class CheckItemInList {
  Future<Either<Failure, Unit>> call(
      String shoppingListId, String itemId, bool isChecked);
}

@Injectable(singleton: false)
class CheckItemInListImpl implements CheckItemInList {
  final ShoppingListRepository repository;
  CheckItemInListImpl(this.repository);

  @override
  Future<Either<Failure, Unit>> call(
      String shoppingListId, String itemId, bool isChecked) async {
    final validateResult = _validate(shoppingListId, itemId);
    if (validateResult != null) return validateResult;
    return await _checkItem(shoppingListId, itemId, isChecked);
  }

  Either<Failure, Unit>? _validate(String shoppingListId, String itemId) {
    if (shoppingListId.isEmpty) {
      return Left(CheckItemFailure(
          AppLocalizations.current.invalidProperty('shoppingListId')));
    }

    if (itemId.isEmpty) {
      return Left(
          CheckItemFailure(AppLocalizations.current.invalidProperty('itemId')));
    }

    return null;
  }

  Future<Either<Failure, Unit>> _checkItem(
      String shoppingListId, String itemId, bool isChecked) {
    final result =
        repository.checkItemInList(shoppingListId, itemId, isChecked);
    return result;
  }
}
