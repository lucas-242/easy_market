import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'core/auth/auth_module.dart';
import 'core/auth/guard/auth_guard.dart';
import 'core/auth/services/auth_service.dart';
import 'core/pages/splash_screen_page.dart';
import 'core/routes/app_routes.dart';
import 'core/routes/deep_links/deep_links_module.dart';
import 'modules/corroboration/corroboration_module.dart';
import 'modules/shopping_list/shopping_list_module.dart';
import 'shared/services/stream_subscriptions_cancel.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => FirebaseFirestore.instance),
        Bind((i) => FirebaseAuth.instance),
        Bind((i) => FirebaseDynamicLinks.instance),
        ...DeepLinksModule.exportedBinds,
        ...AuthModule.exportedBinds,
        $AuthService,
        $StreamSubscriptionsCancel,
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(AppRoutes.main, child: (_, __) => SplashScreenPage()),
        ModuleRoute(AppRoutes.auth, module: CorroborationModule()),
        ModuleRoute(
          AppRoutes.lists,
          module: ShoppingListModule(),
          guards: [AuthGuard()],
        ),
      ];
}
