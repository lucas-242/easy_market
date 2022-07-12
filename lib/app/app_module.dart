import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:market_lists/app/core/app_routes.dart';
import 'package:market_lists/app/core/auth/auth_guard.dart';
import 'package:market_lists/app/core/pages/splash_screen_page.dart';
import 'package:market_lists/app/core/stores/auth_store.dart';
import 'package:market_lists/app/modules/auth/auth_module.dart';
import 'package:market_lists/app/modules/shopping_list/shopping_list_module.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => FirebaseFirestore.instance),
        Bind((i) => FirebaseAuth.instance),
        ...AuthModule.exportedBinds,
        $AuthStore,
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(AppRoutes.main, child: (_, __) => SplashScreenPage()),
        ModuleRoute(AppRoutes.login, module: AuthModule()),
        ModuleRoute(
          AppRoutes.lists,
          module: ShoppingListModule(),
          guards: [AuthGuard()],
        ),
      ];
}
