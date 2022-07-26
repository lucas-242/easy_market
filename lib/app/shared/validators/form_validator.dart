import 'package:easy_market/app/core/auth/domain/utils/credentials_validator_util.dart';
import 'package:easy_market/app/modules/shopping_list/domain/entities/item_type.dart';
import 'package:easy_market/app/shared/extensions/extensions.dart';

mixin FormValidator {
  String? validateTextField({
    required String? fieldValue,
    String? fieldName = 'Name',
  }) {
    return _validateFieldIsEmpty(
      fieldValue: fieldValue,
      fieldName: fieldName,
    );
  }

  String? validateNumberField({
    required String? fieldValue,
    required String fieldName,
  }) {
    String? error = _validateFieldIsEmpty(
      fieldValue: fieldValue,
      fieldName: fieldName,
    );

    if (error != null) {
      return error;
    }

    final convertedValue = double.tryParse(fieldValue!);

    if (convertedValue == null) {
      error = 'Please, inform a valid number';
    } else if (convertedValue <= 0) {
      error = 'Please, inform a number greater than 0';
    }

    return error;
  }

  String? validateItemTypeField({
    required ItemType? fieldValue,
    String? fieldName = 'Type',
  }) {
    return _validateFieldIsEmpty(
      fieldValue: fieldValue.toShortString(),
      fieldName: fieldName,
    );
  }

  String? validateNameField({
    required String? fieldValue,
    String? fieldName = 'Name',
  }) {
    String? error = _validateFieldIsEmpty(
      fieldValue: fieldValue,
      fieldName: fieldName,
    );

    if (error != null) {
      return error;
    }

    if (!CredentialsValidatorUtil.isAName(fieldValue!)) {
      error = 'Please, inform a valid name';
    }

    return error;
  }

  String? validateEmailField({
    required String? fieldValue,
    String? fieldName = 'Email',
  }) {
    String? error = _validateFieldIsEmpty(
      fieldValue: fieldValue,
      fieldName: fieldName,
    );

    if (error != null) {
      return error;
    }

    if (!CredentialsValidatorUtil.isAnEmail(fieldValue!)) {
      error = 'Please, inform a valid email';
    }

    return error;
  }

  String? validatePasswordField({
    required String? fieldValue,
    String? fieldName = 'Password',
  }) {
    String? error = _validateFieldIsEmpty(
      fieldValue: fieldValue,
      fieldName: fieldName,
    );

    if (error != null) {
      return error;
    }

    if (!CredentialsValidatorUtil.isAPassword(fieldValue!)) {
      error = 'Password too short';
    }

    return error;
  }

  String? validateConfirmPasswordField({
    required String? fieldValue,
    required String? targetValue,
    String? fieldName = 'Confirm Password',
    String? targetName = 'Password',
  }) {
    String? error = _validateFieldIsEqual(
      fieldValue: fieldValue,
      targetValue: targetValue,
      fieldName: fieldName,
      targetName: targetName,
    );

    return error;
  }

  String? validateCodeField({
    required String? fieldValue,
    String? fieldName = 'Code',
  }) {
    String? error = _validateFieldIsEmpty(
      fieldValue: fieldValue,
      fieldName: fieldName,
    );

    return error;
  }

  String? _validateFieldIsEqual({
    String? fieldValue,
    String? targetValue,
    String? fieldName,
    String? targetName,
  }) =>
      fieldValue != targetValue
          ? '${fieldName ?? "Field"} must be equals ${targetName ?? targetValue}'
          : null;

  String? _validateFieldIsEmpty({String? fieldValue, String? fieldName}) =>
      fieldValue == null || fieldValue.isEmpty
          ? '${fieldName ?? "Field"} is Empty'
          : null;
}
