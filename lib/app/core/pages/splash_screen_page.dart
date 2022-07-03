import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:market_lists/app/core/app_routes.dart';
import 'package:market_lists/app/core/stores/auth_store.dart';

class SplashScreenPage extends StatelessWidget {
  SplashScreenPage({Key? key}) : super(key: key) {
    var isLogged = false;
    Modular.get<AuthStore>().getCurrentUser().then((result) {
      Future.delayed(const Duration(seconds: 3));
      isLogged = result;
    }).then((value) {
      if (isLogged) {
        Modular.to.pushNamedAndRemoveUntil(AppRoutes.lists, (_) => false);
      } else {
        Modular.to.pushNamedAndRemoveUntil(AppRoutes.login, (_) => false);
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
