import 'package:easy_market/app/modules/auth/domain/utils/credentials_validator_util.dart';

class SignUpCredentials {
  final String name;
  final String email;
  final String password;

  SignUpCredentials(
      {required this.email, required this.password, required this.name});

  bool get isValidEmail => CredentialsValidatorUtil.isAnEmail(email);
  bool get isValidName => CredentialsValidatorUtil.isAName(name);
  bool get isValidPassword => CredentialsValidatorUtil.isAPassword(password);
}
