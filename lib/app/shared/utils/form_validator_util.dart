mixin FormValidatorUtil {
  String? validatePriceField(String? field, {String? fieldName}) {
    final emptyErrorMessage =
        validateFieldIsEmpty(field, fieldName: fieldName ?? 'Field');
    if (emptyErrorMessage != null) {
      return emptyErrorMessage;
    }

    return _validateIsNumberOnly(field!, fieldName: fieldName);
  }

  String? validateFieldIsEmpty(String? fieldValue, {String? fieldName}) =>
      fieldValue == null || fieldValue.isEmpty
          ? '${fieldName ?? "Field"} is Empty'
          : null;

  String? validateNumberField(String? field, {String? fieldName}) {
    if (field == null || field == '') {
      return null;
    }

    return _validateIsNumberOnly(field, fieldName: fieldName);
  }

  String? _validateIsNumberOnly(String field, {String? fieldName}) {
    final errorFormatMessage = '$fieldName is invalid';
    if (RegExp(r'[^0-9.]').hasMatch(field)) {
      return errorFormatMessage;
    }
    return null;
  }
}
