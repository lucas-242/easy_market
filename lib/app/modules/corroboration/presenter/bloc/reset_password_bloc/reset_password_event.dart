part of 'reset_password_bloc.dart';

abstract class ResetPasswordEvent {}

class SendPasswordResetEmailEvent extends ResetPasswordEvent {}

class ConfirmPasswordResetEvent extends ResetPasswordEvent {}

class ChangeEmailEvent extends ResetPasswordEvent {
  final String? email;

  ChangeEmailEvent(this.email);
}

class ChangeCodeEvent extends ResetPasswordEvent {
  final String? code;

  ChangeCodeEvent(this.code);
}

class ChangePasswordEvent extends ResetPasswordEvent {
  final String? password;

  ChangePasswordEvent(this.password);
}

class ChangeConfirmPasswordEvent extends ResetPasswordEvent {
  final String? confirmPassword;

  ChangeConfirmPasswordEvent(this.confirmPassword);
}

class ChangePasswordVisibilyEvent extends ResetPasswordEvent {}

class ChangeConfirmPasswordVisibilyEvent extends ResetPasswordEvent {}
