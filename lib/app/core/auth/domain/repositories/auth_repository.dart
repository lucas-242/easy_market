import 'package:dartz/dartz.dart';
import 'package:market_lists/app/core/auth/domain/entities/user.dart';
import 'package:market_lists/app/core/errors/errors.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> loginByEmail({String email, String password});
  Future<Either<Failure, User>> loginByPhone({String phone});
  Future<Either<Failure, User>> verifyPhoneCode(
      {String verificationId, String code});
  Future<Either<Failure, User>> getLoggedUser();
  Future<Either<Failure, Unit>> logout();
}
