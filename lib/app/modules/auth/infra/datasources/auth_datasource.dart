import 'package:market_lists/app/modules/auth/infra/models/user_model.dart';

abstract class AuthDatasource {
  Future<UserModel> signInWithEmail({
    required String email,
    required String password,
  });
  Future<UserModel> signInWithPhone({required String phone});
  Future<UserModel> verifyPhoneCode({
    required String verificationId,
    required String code,
  });
  Future<UserModel> getCurrentUser();
  Future<void> signOut();
}
