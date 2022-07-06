part of 'sign_up_bloc.dart';

enum SignUpStatus { initial, loading, error, success }

class SignUpState {
  final SignUpStatus status;
  final String? name;
  final String? email;
  final String? password;
  final String? confirmPassword;
  final String callbackMessage;
  final bool showPassword;
  final bool showConfirmPassword;

  SignUpState({
    this.name,
    this.email,
    this.password,
    this.confirmPassword,
    required this.status,
    this.callbackMessage = '',
    this.showPassword = false,
    this.showConfirmPassword = false,
  });

  SignUpState copyWith({
    SignUpStatus? status,
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

  T when<T>({
    T Function(SignUpState state)? onState,
    T Function(SignUpState error)? onError,
    T Function()? onLoading,
  }) {
    switch (status) {
      case SignUpStatus.loading:
        return onLoading!();
      case SignUpStatus.error:
        return onError!(this);
      default:
        return onState!(this);
    }
  }
}
