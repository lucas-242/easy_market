part of 'auth_bloc.dart';

@immutable
abstract class SignInState {
  final String? email;
  final String? phone;
  final String? password;

  const SignInState({this.email, this.password, this.phone});

  SignInState copyWith({String? email, String? password, String? phone});

  T when<T>({
    T Function(SignInState state)? onState,
    T Function(ErrorState error)? onError,
    T Function()? onLoading,
  }) {
    return onState!(this);
  }
}

class InitialState extends SignInState {
  const InitialState({super.email, super.password, super.phone});

  @override
  InitialState copyWith({String? email, String? password, String? phone}) {
    return InitialState(
      email: email ?? this.email,
      password: password ?? this.password,
      phone: phone ?? this.phone,
    );
  }
}

class ErrorState extends SignInState {
  final String message;
  const ErrorState(
      {required this.message, super.email, super.password, super.phone});

  @override
  T when<T>({
    T Function(SignInState state)? onState,
    T Function(ErrorState error)? onError,
    T Function()? onLoading,
  }) =>
      onError!(this);

  @override
  ErrorState copyWith({
    String? email,
    String? password,
    String? message,
    String? phone,
  }) {
    return ErrorState(
      message: message ?? this.message,
      email: email ?? this.email,
      password: password ?? this.password,
      phone: phone ?? this.phone,
    );
  }
}

class SuccessState extends SignInState {
  @override
  SignInState copyWith({String? email, String? password, String? phone}) {
    return SuccessState();
  }
}

class LoadingState extends SignInState {
  LoadingState({
    SignInState? state,
    String? email,
    String? password,
    String? phone,
  }) : super(
          email: state?.email ?? email,
          password: state?.password ?? password,
          phone: state?.phone ?? password,
        );

  @override
  SignInState copyWith({String? email, String? password, String? phone}) {
    return LoadingState(email: email, password: password, phone: phone);
  }
}
