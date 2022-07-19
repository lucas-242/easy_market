part of 'sign_up_bloc.dart';

class SignUpState extends BaseBlocState {
  final String? name;
  final String? email;
  final String? password;
  final String? confirmPassword;
  final bool showPassword;
  final bool showConfirmPassword;

  SignUpState({
    this.name,
    this.email,
    this.password,
    this.confirmPassword,
    required super.status,
    super.callbackMessage = '',
    this.showPassword = false,
    this.showConfirmPassword = false,
  });

  @override
  SignUpState copyWith({
    BaseStateStatus? status,
    String? name,
    String? email,
    String? password,
    String? confirmPassword,
    String? callbackMessage,
    bool? showPassword,
    bool? showConfirmPassword,
  }) {
    return SignUpState(
      status: status ?? this.status,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      callbackMessage: callbackMessage ?? this.callbackMessage,
      showPassword: showPassword ?? this.showPassword,
      showConfirmPassword: showConfirmPassword ?? this.showConfirmPassword,
    );
  }
}
