import 'package:market_lists/app/shared/utils/credentials_validator_util.dart';

class SignUpCredentials with CredentialsValidator {
  final String name;
  final String email;
  final String password;

  SignUpCredentials(
      {required this.email, required this.password, required this.name});

  bool get isValidEmail => isAnEmail(email);
  bool get isValidName => name.isNotEmpty && name.length >= 2;
  bool get isValidPassword => isAPassword(password);
}
