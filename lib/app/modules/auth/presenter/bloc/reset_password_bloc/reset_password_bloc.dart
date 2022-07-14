import 'package:bloc/bloc.dart';
import 'package:easy_market/app/modules/auth/domain/entities/reset_password_credentials.dart';
import 'package:easy_market/app/modules/auth/domain/usecases/confirm_password_reset.dart';
import 'package:easy_market/app/modules/auth/domain/usecases/send_password_reset_email.dart';
import 'package:easy_market/app/shared/utils/base_bloc_state.dart';
import 'package:easy_market/app/shared/utils/form_validator.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState>
    with FormValidator {
  final SendPasswordResetEmail sendPasswordResetEmail;
  final ConfirmPasswordReset confirmPasswordReset;

  ResetPasswordBloc(
    this.sendPasswordResetEmail,
    this.confirmPasswordReset,
  ) : super(ResetPasswordState(status: BaseStateStatus.initial)) {
    on<ChangeEmailEvent>(_onChangeEmail);
    on<ChangeCodeEvent>(_onChangeCode);
    on<ChangePasswordEvent>(_onChangePassword);
    on<ChangeConfirmPasswordEvent>(_onChangeConfirmPassword);
    on<ChangePasswordVisibilyEvent>(_onChangePasswordVisibility);
    on<ChangeConfirmPasswordVisibilyEvent>(_onChangeConfirmPasswordVisibility);
    on<SendPasswordResetEmailEvent>(_onSendPasswordResetEmail);
    on<ConfirmPasswordResetEvent>(_onConfirmPasswordReset);
  }
  void _onChangeEmail(
      ChangeEmailEvent event, Emitter<ResetPasswordState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _onChangeCode(ChangeCodeEvent event, Emitter<ResetPasswordState> emit) {
    emit(state.copyWith(code: event.code));
  }

  void _onChangePassword(
      ChangePasswordEvent event, Emitter<ResetPasswordState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void _onChangeConfirmPassword(
      ChangeConfirmPasswordEvent event, Emitter<ResetPasswordState> emit) {
    emit(state.copyWith(confirmPassword: event.confirmPassword));
  }

  void _onChangePasswordVisibility(
      ChangePasswordVisibilyEvent event, Emitter<ResetPasswordState> emit) {
    emit(state.copyWith(showPassword: !state.showPassword));
  }

  void _onChangeConfirmPasswordVisibility(
      ChangeConfirmPasswordVisibilyEvent event,
      Emitter<ResetPasswordState> emit) {
    emit(state.copyWith(showConfirmPassword: !state.showConfirmPassword));
  }

  Future<void> _onSendPasswordResetEmail(SendPasswordResetEmailEvent event,
      Emitter<ResetPasswordState> emit) async {
    emit(state.copyWith(status: BaseStateStatus.loading));
    final result = await sendPasswordResetEmail(
        ResetPasswordCredentials.sendPasswordResetEmail(email: state.email!));

    result.fold(
      (l) => emit(state.copyWith(
          status: BaseStateStatus.error, callbackMessage: l.message)),
      (r) => emit(ResetPasswordState(status: BaseStateStatus.success)),
    );
  }

  Future<void> _onConfirmPasswordReset(
      ConfirmPasswordResetEvent event, Emitter<ResetPasswordState> emit) async {
    emit(state.copyWith(status: BaseStateStatus.loading));
    final result = await confirmPasswordReset(
        ResetPasswordCredentials.confirmPasswordReset(
            code: state.code!, newPassword: state.password!));

    result.fold(
      (l) => emit(state.copyWith(
          status: BaseStateStatus.error, callbackMessage: l.message)),
      (r) => emit(ResetPasswordState(status: BaseStateStatus.success)),
    );
  }
}
