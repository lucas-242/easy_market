import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:easy_market/app/modules/auth/domain/entities/sign_up_credentials.dart';
import 'package:easy_market/app/modules/auth/domain/usecases/sign_up_with_email.dart';
import 'package:easy_market/app/shared/utils/base_state_status.dart';
import 'package:easy_market/app/shared/utils/form_validator.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> with FormValidator {
  final SignUpWithEmail signUpUsecase;
  SignUpBloc(this.signUpUsecase)
      : super(SignUpState(status: BaseStateStatus.initial)) {
    on<ChangeNameEvent>(_onChangeName);
    on<ChangeEmailEvent>(_onChangeEmail);
    on<ChangePasswordEvent>(_onChangePassword);
    on<ChangeConfirmPasswordEvent>(_onChangeConfirmPassword);
    on<ChangePasswordVisibilyEvent>(_onChangePasswordVisibility);
    on<ChangeConfirmPasswordVisibilyEvent>(_onChangeConfirmPasswordVisibility);
    on<SignUpClickEvent>(_onSignUp);
  }

  void _onChangeName(ChangeNameEvent event, Emitter<SignUpState> emit) {
    emit(state.copyWith(name: event.name));
  }

  void _onChangeEmail(ChangeEmailEvent event, Emitter<SignUpState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _onChangePassword(ChangePasswordEvent event, Emitter<SignUpState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void _onChangeConfirmPassword(
      ChangeConfirmPasswordEvent event, Emitter<SignUpState> emit) {
    emit(state.copyWith(confirmPassword: event.confirmPassword));
  }

  void _onChangePasswordVisibility(
      ChangePasswordVisibilyEvent event, Emitter<SignUpState> emit) {
    emit(state.copyWith(showPassword: !state.showPassword));
  }

  void _onChangeConfirmPasswordVisibility(
      ChangeConfirmPasswordVisibilyEvent event, Emitter<SignUpState> emit) {
    emit(state.copyWith(showConfirmPassword: !state.showConfirmPassword));
  }

  Future<void> _onSignUp(
      SignUpClickEvent event, Emitter<SignUpState> emit) async {
    emit(state.copyWith(status: BaseStateStatus.loading));
    final credentials = SignUpCredentials(
      email: state.email!,
      password: state.password!,
      name: state.name!,
    );
    await _signUp(credentials, emit);
  }

  Future<void> _signUp(
      SignUpCredentials credentials, Emitter<SignUpState> emit) async {
    final response = await signUpUsecase(credentials);
    response.fold(
      (l) => emit(state.copyWith(
          status: BaseStateStatus.error, callbackMessage: l.message)),
      (r) => emit(SignUpState(status: BaseStateStatus.success)),
    );
  }
}
