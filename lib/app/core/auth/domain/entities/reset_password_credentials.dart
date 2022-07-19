import 'package:easy_market/app/core/auth/domain/utils/credentials_validator_util.dart';

class ResetPasswordCredentials {
  final String email;
  final String newPassword;
  final String code;

  ResetPasswordCredentials._({
    this.email = '',
    this.newPassword = '',
    this.code = '',
  });

  factory ResetPasswordCredentials.sendPasswordResetEmail(
      {required String email}) {
    return ResetPasswordCredentials._(
      email: email,
    );
  }

  factory ResetPasswordCredentials.confirmPasswordReset(
      {required String code, required String newPassword}) {
    return ResetPasswordCredentials._(
      code: code,
      newPassword: newPassword,
    );
  }

  bool get isValidEmail => CredentialsValidatorUtil.isAnEmail(email);
  bool get isValidPassword => CredentialsValidatorUtil.isAPassword(newPassword);
  bool get isValidCode => code.isNotEmpty;
}
