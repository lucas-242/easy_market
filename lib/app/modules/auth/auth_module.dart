import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:market_lists/app/core/app_routes.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

import 'domain/usecases/get_current_user.dart';
import 'domain/usecases/sign_in_with_email.dart';
import 'domain/usecases/sign_in_with_phone.dart';
import 'domain/usecases/sign_out.dart';
import 'domain/usecases/sign_up_with_email.dart';
import 'domain/usecases/verify_phone_code.dart';
import 'external/datasources/firebase/firebase_auth_datasource.dart';
import 'infra/repositories/auth_repository_impl.dart';
import 'presenter/bloc/auth_bloc.dart';
import 'presenter/pages/sign_in_page.dart';
import 'presenter/pages/sign_up_page.dart';
import 'presenter/pages/welcome_page.dart';

class AuthModule extends Module {
  static List<Bind> exportedBinds = [
    $GetCurrentUserImpl,
    $SignOutImpl,
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
      (i) => AuthBloc(i<SignInWithEmail>(), i<SignInWithPhone>()),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(AppRoutes.main, child: (_, __) => const WelcomePage()),
    ChildRoute(AppRoutes.signIn, child: (_, __) => const SignInPage()),
    ChildRoute(AppRoutes.signUp, child: (_, __) => const SignUpPage()),
  ];
}
