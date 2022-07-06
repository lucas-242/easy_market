import 'package:bloc/bloc.dart';
import 'package:market_lists/app/modules/auth/domain/usecases/sign_up_with_email.dart';
import 'package:market_lists/app/shared/utils/form_validator_util.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> with FormValidatorUtil {
  final SignUpWithEmail signUpUsecase;
  SignUpBloc(this.signUpUsecase)
      : super(SignUpState(status: SignUpStatus.initial)) {
    on<ChangeNameEvent>(_onChangeName);
    on<ChangeEmailEvent>(_onChangeEmail);
    on<ChangePasswordEvent>(_onChangePassword);
    on<ChangeConfirmPasswordEvent>(_onChangeConfirmPassword);
    on<ChangePasswordVisibilyEvent>(_onChangePasswordVisibility);
    on<ChangeConfirmPasswordVisibilyEvent>(_onChangeConfirmPasswordVisibility);
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
}
