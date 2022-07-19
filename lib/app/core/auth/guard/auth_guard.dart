import 'package:easy_market/app/core/auth/services/auth_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:easy_market/app/core/routes/app_routes.dart';

class AuthGuard extends RouteGuard {
  AuthGuard() : super(redirectTo: AppRoutes.auth);

  @override
  Future<bool> canActivate(String path, ModularRoute route) {
    final service = Modular.get<AuthService>();
    if (!service.isLogged) {
      return service.getCurrentUser();
    }

    return Future.value(true);
  }
}
