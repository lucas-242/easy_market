import 'package:dartz/dartz.dart';
import '../entities/user_info.dart';
import '../../../errors/errors.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserInfo>> signInByEmail({
    required String email,
    required String password,
  });
  Future<Either<Failure, UserInfo>> loginByPhone({required String phone});
  Future<Either<Failure, UserInfo>> verifyPhoneCode({
    required String verificationId,
    required String code,
  });
  Future<Either<Failure, Unit>> sendPasswordResetEmail({required String email});
  Future<Either<Failure, Unit>> confirmPasswordReset({
    required String code,
    required String newPassword,
  });
  Future<Either<Failure, UserInfo>> getCurrentUser();
  Stream<Either<Failure, UserInfo?>> listenCurrentUser();
  Future<Either<Failure, Unit>> signOut();
  Future<Either<Failure, Unit>> signUp({
    required String name,
    required String email,
    required String password,
  });
}
