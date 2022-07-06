import 'package:market_lists/app/modules/auth/domain/entities/credentials_validator.dart';

class SignUpCredentials {
  final String name;
  final String email;
  final String password;

  SignUpCredentials(
      {required this.email, required this.password, required this.name});

  bool get isValidEmail => CredentialsValidator.isAnEmail(email);
  bool get isValidName => CredentialsValidator.isAName(name);
  bool get isValidPassword => CredentialsValidator.isAPassword(password);
}
