import 'package:bloc/bloc.dart';

import '../../../../../core/auth/domain/entities/sign_in_credentials.dart';
import '../../../../../core/auth/domain/usecases/sign_in_with_email.dart';
import '../../../../../core/auth/domain/usecases/sign_in_with_phone.dart';
import '../../../../../shared/entities/base_bloc_state.dart';
import '../../../../../shared/validators/form_validator.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> with FormValidator {
  final SignInWithEmail signInWithEmail;
  final SignInWithPhone signInWithPhone;

  SignInBloc(
    this.signInWithEmail,
    this.signInWithPhone,
  ) : super(SignInState(status: BaseStateStatus.initial)) {
    on<ChangeEmailEvent>(_onChangeEmail);
    on<ChangePasswordEvent>(_onChangePassword);
    on<ChangePasswordVisibilyEvent>(_onChangePasswordVisibility);
    on<SignInWithEmailEvent>(_onSignInWithEmail);
    on<SignInWithPhoneEvent>(_onSignInPhone);
  }

  void _onChangeEmail(ChangeEmailEvent event, Emitter<SignInState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _onChangePassword(ChangePasswordEvent event, Emitter<SignInState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void _onChangePasswordVisibility(
      ChangePasswordVisibilyEvent event, Emitter<SignInState> emit) {
    emit(state.copyWith(showPassword: !state.showPassword));
  }

  Future<void> _onSignInWithEmail(
      SignInWithEmailEvent event, Emitter<SignInState> emit) async {
    emit(state.copyWith(status: BaseStateStatus.loading));

    final result = await signInWithEmail(
      SignInCredentials.withEmailAndPassword(
        email: state.email!,
        password: state.password!,
      ),
    );

    result.fold(
      (l) => emit(state.copyWith(
          status: BaseStateStatus.error, callbackMessage: l.message)),
      (r) => emit(SignInState(status: BaseStateStatus.success)),
    );
  }

  Future<void> _onSignInPhone(
      SignInWithPhoneEvent event, Emitter<SignInState> emit) async {
    emit(state.copyWith(status: BaseStateStatus.loading));
    final result = await signInWithPhone(
      SignInCredentials.withPhone(phone: state.phone!),
    );

    result.fold(
      (l) => emit(state.copyWith(
          status: BaseStateStatus.error, callbackMessage: l.message)),
      (r) => emit(SignInState(status: BaseStateStatus.success)),
    );
  }
}
