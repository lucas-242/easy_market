import 'package:easy_market/app/core/auth/services/auth_service.dart';
import 'package:easy_market/app/core/routes/deep_links/domain/entities/deep_link_data.dart';
import 'package:easy_market/app/core/routes/deep_links/services/routes_service.dart';
import 'package:easy_market/app/core/routes/deep_links_routes.dart';
import 'package:easy_market/app/shared/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:easy_market/app/core/routes/app_routes.dart';

class SplashScreenPage extends StatelessWidget {
  SplashScreenPage({Key? key}) : super(key: key) {
    _checkUserIsLogged();
    _listenInitialLink();
    _listenBackgroudLinks();
  }

  void _checkUserIsLogged() {
    Modular.get<AuthService>().listenCurrentUser().listen((user) {
      if (user == null) {
        Modular.to.pushNamedAndRemoveUntil(AppRoutes.auth, (_) => false);
      }
    }).cancelOnFinishApp();
  }

  void _listenInitialLink() {
    Modular.get<RoutesService>().listenInitialLink().listen(
      (data) {
        if (data != null) {
          _handleDeepLink(data);
        } else {
          Modular.to.pushNamedAndRemoveUntil(AppRoutes.lists, (_) => false);
        }
      },
      cancelOnError: true,
    ).cancelOnFinishApp();
  }

  void _listenBackgroudLinks() {
    Modular.get<RoutesService>()
        .listenBackgroundLinks()
        .listen((data) => _handleDeepLink(data))
        .cancelOnFinishApp();
  }

  void _handleDeepLink(DeepLinkData data) {
    switch (data.path) {
      case DeepLinksRoutes.resetPassword:
        Modular.to.pushNamed(
          AppRoutes.confirmPasswordReset + (data.parameters['oobCode'] ?? ''),
        );
        break;
    }
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
