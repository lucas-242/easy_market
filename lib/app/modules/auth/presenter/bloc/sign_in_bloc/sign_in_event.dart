part of 'sign_in_bloc.dart';

abstract class SignInEvent {}

class SignInWithEmailEvent extends SignInEvent {}

class SignInWithPhoneEvent extends SignInEvent {}

class ChangeEmailEvent extends SignInEvent {
  final String? email;

  ChangeEmailEvent(this.email);
}

class ChangePasswordEvent extends SignInEvent {
  final String? password;

  ChangePasswordEvent(this.password);
}
