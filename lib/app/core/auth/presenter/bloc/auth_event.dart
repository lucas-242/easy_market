part of 'auth_bloc.dart';

abstract class AuthEvent {}

class SignInWithEmailEvent extends AuthEvent {}

class SignInWithPhoneEvent extends AuthEvent {}

class ChangeEmailEvent extends AuthEvent {
  final String? email;

  ChangeEmailEvent(this.email);
}

class ChangePasswordEvent extends AuthEvent {
  final String? password;

  ChangePasswordEvent(this.password);
}
