import 'package:flutter_modular/flutter_modular.dart';
import '../../domain/entities/user_info.dart';
import 'package:dartz/dartz.dart';
import '../../domain/errors/errors.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_datasource.dart';
import '../../../errors/errors.dart';
part 'auth_repository_impl.g.dart';

@Injectable(singleton: false)
class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource datasource;

  AuthRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, UserInfo>> getCurrentUser() async {
    try {
      final user = await datasource.getCurrentUser();
      return Right(user);
    } on Failure catch (error) {
      return Left(GetCurrentUserFailure(error.message));
    } catch (error) {
      return Left(GetCurrentUserFailure("Error to get logged user."));
    }
  }

  @override
  Stream<Either<Failure, UserInfo?>> listenCurrentUser() {
    try {
      return datasource
          .listenCurrentUser()
          .handleError((error) => Left(GetCurrentUserFailure(error.message)))
          .map((user) => Right(user));
    } on Failure catch (error) {
      return Stream.value(Left(GetCurrentUserFailure(error.message)));
    } catch (error) {
      return Stream.value(
          Left(GetCurrentUserFailure("Error to get logged user.")));
    }
  }

  @override
  Future<Either<Failure, UserInfo>> signInByEmail(
      {required String email, required String password}) async {
    try {
      final user =
          await datasource.signInWithEmail(email: email, password: password);
      return Right(user);
    } on Failure catch (error) {
      return Left(SignInWithEmailFailure(error.message));
    } catch (error) {
      return Left(SignInWithEmailFailure("Error to login with email."));
    }
  }

  @override
  Future<Either<Failure, UserInfo>> loginByPhone(
      {required String phone}) async {
    try {
      final user = await datasource.signInWithPhone(phone: phone);
      return Right(user);
    } on Failure catch (error) {
      return Left(SignInWithPhoneFailure(error.message));
    } catch (error) {
      return Left(SignInWithPhoneFailure("Error to login with phone."));
    }
  }

  @override
  Future<Either<Failure, UserInfo>> verifyPhoneCode(
      {required String verificationId, required String code}) async {
    try {
      final user = await datasource.verifyPhoneCode(
          code: code, verificationId: verificationId);
      return Right(user);
    } on Failure catch (error) {
      return Left(SignInWithPhoneFailure(error.message));
    } catch (error) {
      return Left(SignInWithPhoneFailure("Error to verify phone code."));
    }
  }

  @override
  Future<Either<Failure, Unit>> signOut() async {
    try {
      await datasource.signOut();
      return const Right(unit);
    } on Failure catch (error) {
      return Left(SignOutFailure(error.message));
    } catch (error) {
      return Left(SignOutFailure("Error to logout."));
    }
  }

  @override
  Future<Either<Failure, Unit>> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      await datasource.signUp(
        name: name,
        email: email,
        password: password,
      );
      return const Right(unit);
    } on Failure catch (error) {
      return Left(SignUpFailure(error.message));
    } catch (error) {
      return Left(SignUpFailure("Error to sign up."));
    }
  }

  @override
  Future<Either<Failure, Unit>> sendPasswordResetEmail({
    required String email,
  }) async {
    try {
      await datasource.sendPasswordResetEmail(email: email);
      return const Right(unit);
    } on Failure catch (error) {
      return Left(ResetPasswordFailure(error.message));
    } catch (error) {
      return Left(ResetPasswordFailure("Error to reset password."));
    }
  }

  @override
  Future<Either<Failure, Unit>> confirmPasswordReset({
    required String code,
    required String newPassword,
  }) async {
    try {
      await datasource.confirmPasswordReset(
          code: code, newPassword: newPassword);
      return const Right(unit);
    } on Failure catch (error) {
      return Left(ResetPasswordFailure(error.message));
    } catch (error) {
      return Left(ResetPasswordFailure("Error to reset password."));
    }
  }
}
