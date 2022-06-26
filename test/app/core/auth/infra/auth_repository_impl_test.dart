import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:market_lists/app/core/auth/domain/errors/errors.dart';
import 'package:market_lists/app/core/auth/infra/repositories/auth_repository_impl.dart';
import 'package:mockito/mockito.dart';

import '../auth_mock_test.dart';
import '../auth_mock_test.mocks.dart';

void main() {
  final datasource = MockAuthDatasourceTest();
  final repository = AuthRepositoryImpl(datasource);
  final userToLogin = userModel;

  group('Login by Email', () {
    const passwordToLogin = '123456';

    test('Should login with email', () async {
      when(datasource.signInWithEmail(
              email: userToLogin.email, password: passwordToLogin))
          .thenAnswer((_) async => userToLogin);
      final result = await repository.loginByEmail(
          email: userToLogin.email, password: passwordToLogin);

      expect(result, Right(userToLogin));
    });

    test('Should throw LoginByEmailFailure', () async {
      when(datasource.signInWithEmail(
              email: userToLogin.email, password: passwordToLogin))
          .thenThrow((_) async => SignInWithEmailFailure('test'));
      final result = await repository.loginByEmail(
          email: userToLogin.email, password: passwordToLogin);

      expect(
          result.leftMap((l) => l is SignInWithEmailFailure), const Left(true));
    });
  });

  group('Login by phone', () {
    test('Should login with phone', () async {
      when(datasource.signInWithPhone(phone: userToLogin.phone))
          .thenAnswer((_) async => userToLogin);
      final result = await repository.loginByPhone(phone: userToLogin.phone);

      expect(result, Right(userToLogin));
    });

    test('Should throw LoginByPhoneFailure', () async {
      when(datasource.signInWithPhone(phone: userToLogin.phone))
          .thenThrow((_) async => SignInWithPhoneFailure('test'));
      final result = await repository.loginByPhone(phone: userToLogin.phone);

      expect(
          result.leftMap((l) => l is SignInWithPhoneFailure), const Left(true));
    });
  });

  group('Verify phone code', () {
    const String code = 'abc123';
    const String verificationId = '123456';

    test('Should login with phone code', () async {
      when(datasource.verifyPhoneCode(
              code: code, verificationId: verificationId))
          .thenAnswer((_) async => userToLogin);
      final result = await repository.verifyPhoneCode(
          code: code, verificationId: verificationId);

      expect(result, Right(userToLogin));
    });

    test('Should throw LoginByPhoneFailure', () async {
      when(datasource.verifyPhoneCode(
              code: code, verificationId: verificationId))
          .thenThrow((_) async => SignInWithPhoneFailure('test'));
      final result = await repository.verifyPhoneCode(
          code: code, verificationId: verificationId);

      expect(
          result.leftMap((l) => l is SignInWithPhoneFailure), const Left(true));
    });
  });

  group('Get Logged User', () {
    test('Should Get logged user', () async {
      when(datasource.getCurrentUser()).thenAnswer((_) async => userToLogin);
      final result = await repository.getCurrentUser();

      expect(result, Right(userToLogin));
    });

    test('Should throw GetLoggedUserFailure', () async {
      when(datasource.getCurrentUser())
          .thenThrow((_) async => GetCurrentUserFailure('test'));
      final result = await repository.getCurrentUser();

      expect(
          result.leftMap((l) => l is GetCurrentUserFailure), const Left(true));
    });
  });

  group('Logout', () {
    test('Should logout', () async {
      when(datasource.signOut()).thenAnswer((_) async => unit);
      final result = await repository.logout();

      expect(result, const Right(unit));
    });

    test('Should throw LogoutFailure', () async {
      when(datasource.signOut()).thenThrow((_) async => SignOutFailure('test'));
      final result = await repository.logout();

      expect(result.leftMap((l) => l is SignOutFailure), const Left(true));
    });
  });
}
