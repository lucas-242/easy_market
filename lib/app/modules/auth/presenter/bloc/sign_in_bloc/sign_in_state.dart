part of 'sign_in_bloc.dart';

class SignInState {
  final BaseStateStatus status;
  final String? email;
  final String? phone;
  final String? password;
  final String callbackMessage;
  final bool showPassword;
  final bool showConfirmPassword;

  const SignInState({
    this.email,
    this.password,
    this.phone,
    required this.status,
    this.callbackMessage = '',
    this.showPassword = false,
    this.showConfirmPassword = false,
  });

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

  T when<T>({
    required T Function(SignInState state) onState,
    T Function(SignInState error)? onError,
    T Function()? onLoading,
  }) {
    switch (status) {
      case BaseStateStatus.loading:
        return onLoading!();
      case BaseStateStatus.error:
        return onError != null ? onError(this) : onState(this);
      default:
        return onState(this);
    }
  }
}
