// ignore_for_file: avoid_print

import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_market/app/modules/auth/domain/errors/errors.dart';
import 'package:easy_market/app/modules/auth/infra/models/user_model.dart';
import 'package:easy_market/app/modules/auth/infra/repositories/auth_repository_impl.dart';
import 'package:mockito/mockito.dart';

import '../auth_mock_test.dart';
import '../auth_mock_test.mocks.dart';

void main() {
  final datasource = MockAuthDatasource();
  final repository = AuthRepositoryImpl(datasource);
  final userToLogin = userModel;
  final userStream = MockStream<UserModel?>();

  group('Login by Email', () {
    const passwordToLogin = '123456';

    test('Should login with email', () async {
      when(datasource.signInWithEmail(
              email: userToLogin.email, password: passwordToLogin))
          .thenAnswer((_) async => userToLogin);
      final result = await repository.signInByEmail(
          email: userToLogin.email, password: passwordToLogin);

      expect(result, Right(userToLogin));
    });

    test('Should throw LoginByEmailFailure', () async {
      when(datasource.signInWithEmail(
              email: userToLogin.email, password: passwordToLogin))
          .thenThrow((_) async => SignInWithEmailFailure('test'));
      final result = await repository.signInByEmail(
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
    test('Should Get current user', () async {
      when(datasource.getCurrentUser()).thenAnswer((_) async => userToLogin);
      final result = await repository.getCurrentUser();

      expect(result, Right(userToLogin));
    });

    test('Should throw GetCurrentUserFailure', () async {
      when(datasource.getCurrentUser())
          .thenThrow((_) async => GetCurrentUserFailure('test'));
      final result = await repository.getCurrentUser();

      expect(
          result.leftMap((l) => l is GetCurrentUserFailure), const Left(true));
    });
  });

  group('Listen Current User', () {
    test('Should listen current user', () {
      final user = userModel;
      when(datasource.listenCurrentUser()).thenAnswer((_) => userStream);
      when(userStream.listen(any)).thenAnswer((invocation) {
        return Stream.value(user).listen(invocation.positionalArguments.first);
      });
      final result = repository.listenCurrentUser();

      result.listen((event) {
        event.fold((l) => print(l), (r) {
          expect(r, user);
        });
      });
    });

    test('Should throw GetCurrentUserFailure', () {
      when(datasource.listenCurrentUser())
          .thenThrow((_) => GetCurrentUserFailure('test'));

      final result = repository.listenCurrentUser();

      expect(result, isNotNull);
      result.listen((event) {
        expect(
            event.leftMap((l) => l is GetCurrentUserFailure), const Left(true));
      });
    });
  });

  group('Logout', () {
    test('Should logout', () async {
      when(datasource.signOut()).thenAnswer((_) async => unit);
      final result = await repository.signOut();

      expect(result, const Right(unit));
    });

    test('Should throw LogoutFailure', () async {
      when(datasource.signOut()).thenThrow((_) async => SignOutFailure('test'));
      final result = await repository.signOut();

      expect(result.leftMap((l) => l is SignOutFailure), const Left(true));
    });
  });

  group('Sign up', () {
    test('Should sign up', () async {
      when(datasource.signUp(
        name: anyNamed('name'),
        email: anyNamed('email'),
        password: anyNamed('password'),
      )).thenAnswer((_) async => unit);
      final result = await repository.signUp(
        email: userToLogin.email,
        password: 'abc123',
        name: userToLogin.name,
      );

      expect(result, const Right(unit));
    });

    test('Should throw SignUpFailure', () async {
      when(datasource.signUp(
        name: anyNamed('name'),
        email: anyNamed('email'),
        password: anyNamed('password'),
      )).thenThrow((_) async => SignUpFailure('test'));
      final result = await repository.signUp(
        email: userToLogin.email,
        password: 'abc123',
        name: userToLogin.name,
      );

      expect(result.leftMap((l) => l is SignUpFailure), const Left(true));
    });
  });

  group('Send reset password email', () {
    test('Should send reset password email', () async {
      when(datasource.sendPasswordResetEmail(
        email: anyNamed('email'),
      )).thenAnswer((_) async => unit);
      final result =
          await repository.sendPasswordResetEmail(email: userToLogin.email);

      expect(result, const Right(unit));
    });

    test('Should throw ResetPasswordFailure', () async {
      when(datasource.sendPasswordResetEmail(
        email: anyNamed('email'),
      )).thenThrow((_) async => ResetPasswordFailure('test'));
      final result =
          await repository.sendPasswordResetEmail(email: userToLogin.email);

      expect(
          result.leftMap((l) => l is ResetPasswordFailure), const Left(true));
    });
  });

  group('Confirm reset password', () {
    test('Should confirm reset password', () async {
      when(datasource.confirmPasswordReset(
        code: anyNamed('code'),
        newPassword: anyNamed('newPassword'),
      )).thenAnswer((_) async => unit);

      final result = await repository.confirmPasswordReset(
          code: '123', newPassword: '123456');

      expect(result, const Right(unit));
    });

    test('Should throw ResetPasswordFailure', () async {
      when(datasource.confirmPasswordReset(
        code: anyNamed('code'),
        newPassword: anyNamed('newPassword'),
      )).thenThrow((_) async => ResetPasswordFailure('test'));

      final result = await repository.confirmPasswordReset(
          code: '123', newPassword: '123456');

      expect(
          result.leftMap((l) => l is ResetPasswordFailure), const Left(true));
    });
  });
}
