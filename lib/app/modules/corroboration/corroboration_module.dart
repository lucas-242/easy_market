import 'package:easy_market/app/core/auth/domain/usecases/confirm_password_reset.dart';
import 'package:easy_market/app/core/auth/domain/usecases/send_password_reset_email.dart';
import 'package:easy_market/app/core/auth/domain/usecases/sign_in_with_email.dart';
import 'package:easy_market/app/core/auth/domain/usecases/sign_in_with_phone.dart';
import 'package:easy_market/app/core/auth/domain/usecases/sign_up_with_email.dart';
import 'package:easy_market/app/core/routes/utils/routes_utils.dart';
import 'package:easy_market/app/modules/corroboration/presenter/pages/feedback_password_reset_email.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:easy_market/app/core/routes/app_routes.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

import 'presenter/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'presenter/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'presenter/bloc/reset_password_bloc/reset_password_bloc.dart';
import 'presenter/pages/confirm_password_reset_page.dart';
import 'presenter/pages/send_password_reset_email_page.dart';
import 'presenter/pages/sign_in_page.dart';
import 'presenter/pages/sign_up_page.dart';
import 'presenter/pages/welcome_page.dart';

class CorroborationModule extends Module {
  @override
  final List<Bind> binds = [
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
      RoutesUtils.lastPathInRoute(AppRoutes.signIn),
      child: (_, __) => const SignInPage(),
    ),
    ChildRoute(
      RoutesUtils.lastPathInRoute(AppRoutes.signUp),
      child: (_, __) => const SignUpPage(),
    ),
    ChildRoute(
      RoutesUtils.lastPathInRoute(AppRoutes.sendPasswordResetEmail),
      child: (_, __) => const SendPasswordResetEmailPage(),
    ),
    ChildRoute(
      RoutesUtils.lastPathInRoute(AppRoutes.confirmPasswordReset),
      child: (_, __) => const ConfirmPasswordResetPage(),
    ),
    ChildRoute(
      RoutesUtils.lastPathInRoute(AppRoutes.feedbackPasswordResetEmail),
      child: (_, __) => const FeedbackPasswordResetEmail(),
    ),
  ];
}
