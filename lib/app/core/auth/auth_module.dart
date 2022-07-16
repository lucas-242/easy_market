import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';

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
    $SignInWithEmailImpl,
    $SignInWithPhoneImpl,
    $SignUpWithEmailImpl,
    $VerifyPhoneCodeImpl,
  ];

  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [];
}
