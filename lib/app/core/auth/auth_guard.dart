import 'package:flutter_modular/flutter_modular.dart';
import 'package:easy_market/app/core/routes/app_routes.dart';
import 'package:easy_market/app/core/stores/auth_store.dart';

class AuthGuard extends RouteGuard {
  AuthGuard() : super(redirectTo: AppRoutes.signIn);

  @override
  Future<bool> canActivate(String path, ModularRoute route) {
    final store = Modular.get<AuthStore>();
    if (!store.isLogged) {
      return store.getCurrentUser();
    }

    return Future.value(true);
  }
}
