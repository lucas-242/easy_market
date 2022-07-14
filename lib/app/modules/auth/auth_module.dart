import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:easy_market/app/core/routes/app_routes.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

import 'domain/usecases/confirm_password_reset.dart';
import 'domain/usecases/get_current_user.dart';
import 'domain/usecases/listen_current_user.dart';
import 'domain/usecases/send_password_reset_email.dart';
import 'domain/usecases/sign_in_with_email.dart';
import 'domain/usecases/sign_in_with_phone.dart';
import 'domain/usecases/sign_out.dart';
import 'domain/usecases/sign_up_with_email.dart';
import 'domain/usecases/verify_phone_code.dart';
import 'external/datasources/firebase/firebase_auth_datasource.dart';
import 'infra/repositories/auth_repository_impl.dart';
import 'presenter/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'presenter/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'presenter/bloc/reset_password_bloc/reset_password_bloc.dart';
import 'presenter/pages/confirm_password_reset_page.dart';
import 'presenter/pages/send_password_reset_email_page.dart';
import 'presenter/pages/sign_in_page.dart';
import 'presenter/pages/sign_up_page.dart';
import 'presenter/pages/welcome_page.dart';

class AuthModule extends Module {
  static List<Bind> exportedBinds = [
    $GetCurrentUserImpl,
    $ListenCurrentUserImpl,
    $SignOutImpl,
    $SendPasswordResetEmailImpl,
    $ConfirmPasswordResetImpl,
    $AuthRepositoryImpl,
    BindInject(
      (i) => FirebaseAuthDatasource(i<FirebaseAuth>(), i<FirebaseFirestore>()),
      isSingleton: false,
      isLazy: true,
    ),
  ];

  @override
  final List<Bind> binds = [
    $SignInWithEmailImpl,
    $SignInWithPhoneImpl,
    $SignUpWithEmailImpl,
    $VerifyPhoneCodeImpl,
    BlocBind.singleton(
      (i) => SignInBloc(
        i<SignInWithEmail>(),
        i<SignInWithPhone>(),
      ),
    ),
    BlocBind.singleton(
      (i) => ResetPasswordBloc(
        i<SendPasswordResetEmail>(),
        i<ConfirmPasswordReset>(),
      ),
    ),
    BlocBind.singleton(
      (i) => SignUpBloc(i<SignUpWithEmail>()),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(AppRoutes.main, child: (_, __) => const WelcomePage()),
    ChildRoute(
      AppRoutes.lastPathInRoute(AppRoutes.signIn),
      child: (_, __) => const SignInPage(),
    ),
    ChildRoute(
      AppRoutes.lastPathInRoute(AppRoutes.signUp),
      child: (_, __) => const SignUpPage(),
    ),
    ChildRoute(
      AppRoutes.lastPathInRoute(AppRoutes.sendPasswordResetEmail),
      child: (_, __) => const SendPasswordResetEmailPage(),
    ),
    ChildRoute(
      AppRoutes.lastPathInRoute(AppRoutes.confirmPasswordReset),
      child: (_, __) => const ConfirmPasswordResetPage(),
    ),
  ];
}
