extension EnumExtension on Enum {
  String toShortString() {
    // ignore: unnecessary_this
    return this.toString().split('.').last;
  }
}

extension EnumNullableExtension on Enum? {
  String? toShortString() {
    if (this == null) {
      return null;
    }

    // ignore: unnecessary_this
    return this.toString().split('.').last;
  }
}
