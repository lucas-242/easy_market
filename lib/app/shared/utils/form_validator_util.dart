import 'package:market_lists/app/modules/auth/domain/entities/credentials_validator.dart';

mixin FormValidatorUtil {
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

    if (!CredentialsValidator.isAName(fieldValue!)) {
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

    if (!CredentialsValidator.isAnEmail(fieldValue!)) {
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

    if (!CredentialsValidator.isAPassword(fieldValue!)) {
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
