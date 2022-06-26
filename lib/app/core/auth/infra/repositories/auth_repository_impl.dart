import 'package:flutter_modular/flutter_modular.dart';
import 'package:market_lists/app/core/auth/domain/entities/user_info.dart';
import 'package:dartz/dartz.dart';
import 'package:market_lists/app/core/auth/domain/errors/errors.dart';
import 'package:market_lists/app/core/auth/domain/repositories/auth_repository.dart';
import 'package:market_lists/app/core/auth/infra/datasources/auth_datasource.dart';
import 'package:market_lists/app/core/errors/errors.dart';

@Injectable(singleton: false)
class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource datasource;

  AuthRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, UserInfo>> getCurrentUser() async {
    try {
      final user = await datasource.getCurrentUser();
      return Right(user);
    } catch (error) {
      return Left(GetCurrentUserFailure("Erro to get logged user"));
    }
  }

  @override
  Future<Either<Failure, UserInfo>> loginByEmail(
      {required String email, required String password}) async {
    try {
      final user =
          await datasource.signInWithEmail(email: email, password: password);
      return Right(user);
    } catch (error) {
      return Left(SignInWithEmailFailure("Erro to login with email"));
    }
  }

  @override
  Future<Either<Failure, UserInfo>> loginByPhone(
      {required String phone}) async {
    try {
      final user = await datasource.signInWithPhone(phone: phone);
      return Right(user);
    } catch (error) {
      return Left(SignInWithPhoneFailure("Erro to login with phone"));
    }
  }

  @override
  Future<Either<Failure, UserInfo>> verifyPhoneCode(
      {required String verificationId, required String code}) async {
    try {
      final user = await datasource.verifyPhoneCode(
          code: code, verificationId: verificationId);
      return Right(user);
    } catch (error) {
      return Left(SignInWithPhoneFailure("Erro to verify phone code"));
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    try {
      await datasource.signOut();
      return const Right(unit);
    } catch (error) {
      return Left(SignOutFailure("Erro to logout"));
    }
  }
}
