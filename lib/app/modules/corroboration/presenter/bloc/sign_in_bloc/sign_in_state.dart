part of 'sign_in_bloc.dart';

class SignInState extends BaseBlocState {
  final String? email;
  final String? phone;
  final String? password;
  final bool showPassword;
  final bool showConfirmPassword;

  SignInState({
    this.email,
    this.password,
    this.phone,
    required super.status,
    super.callbackMessage = '',
    this.showPassword = false,
    this.showConfirmPassword = false,
  });

  @override
  SignInState copyWith({
    BaseStateStatus? status,
    String? email,
    String? phone,
    String? password,
    String? callbackMessage,
    bool? showPassword,
  }) {
    return SignInState(
      status: status ?? this.status,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      callbackMessage: callbackMessage ?? this.callbackMessage,
      showPassword: showPassword ?? this.showPassword,
    );
  }
}
