abstract class CredentialsValidatorUtil {
  static bool isAName(String name) => name.isNotEmpty && name.length >= 2;

  static bool isAPassword(String password) =>
      password.isNotEmpty && password.length >= 6;

  static bool isAnEmail(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  static bool isAPhone(String phone) {
    return RegExp(r'^\(?[1-9]{2}\)? ?[9] ?[0-9]{4}\-?[0-9]{4}$')
        .hasMatch(phone);
  }
}
