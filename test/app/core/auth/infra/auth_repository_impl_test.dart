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
      when(datasource.loginByEmail(
              email: userToLogin.email, password: passwordToLogin))
          .thenAnswer((_) async => userToLogin);
      final result = await repository.loginByEmail(
          email: userToLogin.email, password: passwordToLogin);

      expect(result, Right(userToLogin));
    });

    test('Should throw LoginByEmailFailure', () async {
      when(datasource.loginByEmail(
              email: userToLogin.email, password: passwordToLogin))
          .thenThrow((_) async => LoginByEmailFailure('test'));
      final result = await repository.loginByEmail(
          email: userToLogin.email, password: passwordToLogin);

      expect(result.leftMap((l) => l is LoginByEmailFailure), const Left(true));
    });
  });

  group('Login by phone', () {
    test('Should login with phone', () async {
      when(datasource.loginByPhone(phone: userToLogin.phone))
          .thenAnswer((_) async => userToLogin);
      final result = await repository.loginByPhone(phone: userToLogin.phone);

      expect(result, Right(userToLogin));
    });

    test('Should throw LoginByPhoneFailure', () async {
      when(datasource.loginByPhone(phone: userToLogin.phone))
          .thenThrow((_) async => LoginByPhoneFailure('test'));
      final result = await repository.loginByPhone(phone: userToLogin.phone);

      expect(result.leftMap((l) => l is LoginByPhoneFailure), const Left(true));
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
          .thenThrow((_) async => LoginByPhoneFailure('test'));
      final result = await repository.verifyPhoneCode(
          code: code, verificationId: verificationId);

      expect(result.leftMap((l) => l is LoginByPhoneFailure), const Left(true));
    });
  });

  group('Get Logged User', () {
    test('Should Get logged user', () async {
      when(datasource.getLoggedUser()).thenAnswer((_) async => userToLogin);
      final result = await repository.getLoggedUser();

      expect(result, Right(userToLogin));
    });

    test('Should throw GetLoggedUserFailure', () async {
      when(datasource.getLoggedUser())
          .thenThrow((_) async => GetLoggedUserFailure('test'));
      final result = await repository.getLoggedUser();

      expect(
          result.leftMap((l) => l is GetLoggedUserFailure), const Left(true));
    });
  });

  group('Logout', () {
    test('Should logout', () async {
      when(datasource.logout()).thenAnswer((_) async => unit);
      final result = await repository.logout();

      expect(result, const Right(unit));
    });

    test('Should throw LogoutFailure', () async {
      when(datasource.logout()).thenThrow((_) async => LogoutFailure('test'));
      final result = await repository.logout();

      expect(result.leftMap((l) => l is LogoutFailure), const Left(true));
    });
  });
}
