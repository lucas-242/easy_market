import 'package:dartz/dartz.dart';
import 'package:market_lists/app/modules/auth/domain/entities/user_info.dart';
import 'package:market_lists/app/core/errors/errors.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserInfo>> loginByEmail({
    required String email,
    required String password,
  });
  Future<Either<Failure, UserInfo>> loginByPhone({required String phone});
  Future<Either<Failure, UserInfo>> verifyPhoneCode({
    required String verificationId,
    required String code,
  });
  Future<Either<Failure, UserInfo>> getCurrentUser();
  Future<Either<Failure, Unit>> logout();
}
