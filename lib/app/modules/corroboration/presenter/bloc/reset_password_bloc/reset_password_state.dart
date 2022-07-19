part of 'reset_password_bloc.dart';

class ResetPasswordState extends BaseBlocState {
  String? email;
  String? password;
  String? confirmPassword;
  String? code;
  final bool showPassword;
  final bool showConfirmPassword;

  ResetPasswordState({
    required super.status,
    super.callbackMessage,
    this.email,
    this.password,
    this.confirmPassword,
    this.code,
    this.showPassword = false,
    this.showConfirmPassword = false,
  });

  @override
  ResetPasswordState copyWith({
    BaseStateStatus? status,
    String? callbackMessage,
    String? email,
    String? password,
    String? confirmPassword,
    String? code,
    bool? showPassword,
    bool? showConfirmPassword,
  }) {
    return ResetPasswordState(
      status: status ?? this.status,
      callbackMessage: callbackMessage ?? this.callbackMessage,
      email: email ?? this.email,
      code: code ?? this.code,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      showPassword: showPassword ?? this.showPassword,
      showConfirmPassword: showConfirmPassword ?? this.showConfirmPassword,
    );
  }
}
