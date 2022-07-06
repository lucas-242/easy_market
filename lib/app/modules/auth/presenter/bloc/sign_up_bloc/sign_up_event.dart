part of 'sign_up_bloc.dart';

abstract class SignUpEvent {}

class SignUp extends SignUpEvent {}

class ChangeNameEvent extends SignUpEvent {
  final String? name;

  ChangeNameEvent(this.name);
}

class ChangeEmailEvent extends SignUpEvent {
  final String? email;

  ChangeEmailEvent(this.email);
}

class ChangePasswordEvent extends SignUpEvent {
  final String? password;

  ChangePasswordEvent(this.password);
}

class ChangeConfirmPasswordEvent extends SignUpEvent {
  final String? confirmPassword;

  ChangeConfirmPasswordEvent(this.confirmPassword);
}

class ChangePasswordVisibilyEvent extends SignUpEvent {}

class ChangeConfirmPasswordVisibilyEvent extends SignUpEvent {}
