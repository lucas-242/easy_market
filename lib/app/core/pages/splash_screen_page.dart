import 'package:easy_market/app/core/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:easy_market/app/core/routes/app_routes.dart';

class SplashScreenPage extends StatelessWidget {
  SplashScreenPage({Key? key}) : super(key: key) {
    _checkUserIsLogged();
  }

  void _checkUserIsLogged() {
    Modular.get<AuthService>().listenCurrentUser().listen((user) {
      if (user != null) {
        Modular.to.pushNamedAndRemoveUntil(AppRoutes.lists, (_) => false);
      } else {
        Modular.to.pushNamedAndRemoveUntil(AppRoutes.auth, (_) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
