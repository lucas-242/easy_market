import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:market_lists/app/core/app_routes.dart';
import 'package:market_lists/app/core/pages/splash_screen_page.dart';
import 'package:market_lists/app/modules/shopping_list/shopping_list_module.dart';
import 'package:market_lists/firebase_options.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform)),
        Bind((i) => FirebaseFirestore.instance),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(AppRoutes.main, child: (_, __) => SplashScreenPage()),
        ModuleRoute(AppRoutes.lists, module: ShoppingListModule()),
      ];
}
