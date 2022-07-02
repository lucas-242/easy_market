import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:market_lists/app/modules/auth/domain/entities/sign_in_credentials.dart';
import 'package:market_lists/app/modules/auth/domain/usecases/sign_in_with_email.dart';
import 'package:market_lists/app/modules/auth/domain/usecases/sign_in_with_phone.dart';
import 'package:market_lists/app/shared/utils/form_validator_util.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> with FormValidatorUtil {
  final SignInWithEmail signInWithEmailUsecase;
  final SignInWithPhone signInWithPhoneUsecase;

  AuthBloc(
    this.signInWithEmailUsecase,
    this.signInWithPhoneUsecase,
  ) : super(const InitialState()) {
    on<ChangeEmailEvent>(_onChangeEmail);
    on<ChangePasswordEvent>(_onChangePassword);
    on<SignInWithEmailEvent>(_onSignInWithEmail);
    on<SignInWithPhoneEvent>(_onSignInPhone);
  }

  void _onChangeEmail(ChangeEmailEvent event, Emitter<AuthState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _onChangePassword(ChangePasswordEvent event, Emitter<AuthState> emit) {
    emit(state.copyWith(password: event.password));
  }

  Future<void> _onSignInWithEmail(
      SignInWithEmailEvent event, Emitter<AuthState> emit) async {
    emit(LoadingState(state: state));
    final result = await signInWithEmailUsecase(
      SignInCredentials.withEmailAndPassword(
        email: state.email!,
        password: state.password!,
      ),
    );

    result.fold(
      (l) => emit(
        ErrorState(message: l.message, email: state.email),
      ),
      (r) => emit(SuccessState()),
    );
  }

  Future<void> _onSignInPhone(
      SignInWithPhoneEvent event, Emitter<AuthState> emit) async {
    emit(LoadingState(state: state));
    final result = await signInWithPhoneUsecase(
      SignInCredentials.withPhone(phone: state.phone!),
    );

    result.fold(
      (l) => emit(
        ErrorState(message: l.message, phone: state.phone),
      ),
      (r) => emit(SuccessState()),
    );
  }
}
