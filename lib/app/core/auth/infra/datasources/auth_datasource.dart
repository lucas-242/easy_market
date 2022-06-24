import 'package:market_lists/app/core/auth/infra/models/user_model.dart';

abstract class AuthDatasource {
  Future<UserModel> loginByEmail({
    required String email,
    required String password,
  });
  Future<UserModel> loginByPhone({required String phone});
  Future<UserModel> verifyPhoneCode({
    required String verificationId,
    required String code,
  });
  Future<UserModel> getLoggedUser();
  Future<void> logout();
}
