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
  Future<void> sendPasswordResetEmail({required String email});
  Future<void> confirmPasswordReset({
    required String code,
    required String newPassword,
  });
  Future<UserModel> getCurrentUser();
  Stream<UserModel?> listenCurrentUser();
  Future<void> signOut();
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  });
}
