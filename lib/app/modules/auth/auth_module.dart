import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:market_lists/app/core/app_routes.dart';
import 'package:market_lists/app/modules/auth/domain/usecases/get_current_user.dart';
import 'package:market_lists/app/modules/auth/domain/usecases/sign_in_with_email.dart';
import 'package:market_lists/app/modules/auth/domain/usecases/sign_in_with_phone.dart';
import 'package:market_lists/app/modules/auth/domain/usecases/sign_out.dart';
import 'package:market_lists/app/modules/auth/domain/usecases/sign_up_with_email.dart';
import 'package:market_lists/app/modules/auth/domain/usecases/verify_phone_code.dart';
import 'package:market_lists/app/modules/auth/external/datasources/firebase/firebase_auth_datasource.dart';
import 'package:market_lists/app/modules/auth/infra/repositories/auth_repository_impl.dart';
import 'package:market_lists/app/modules/auth/presenter/bloc/auth_bloc.dart';
import 'package:market_lists/app/modules/auth/presenter/pages/sign_in_page.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

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
    ChildRoute(AppRoutes.main, child: (_, __) => const SignInPage()),
  ];
}
