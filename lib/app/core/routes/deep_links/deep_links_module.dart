import 'package:easy_market/app/core/routes/deep_links/domain/usecases/listen_background_links.dart';
import 'package:easy_market/app/core/routes/deep_links/domain/usecases/listen_initial_link.dart';
import 'package:easy_market/app/core/routes/deep_links/external/datasources/firebase/firebase_deep_links_handle_datasource.dart';
import 'package:easy_market/app/core/routes/deep_links/infra/repositories/deep_links_handle_repository_impl.dart';
import 'package:easy_market/app/core/routes/deep_links/services/routes_service.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DeepLinksModule extends Module {
  static List<Bind> exportedBinds = [
    $ListenInitialLinkImpl,
    $ListenBackgroundLinksImpl,
    $DeepLinksHandleRepositoryImpl,
    $RoutesService,
    BindInject(
      (i) => FirebaseDeepLinksHandleDatasource(i<FirebaseDynamicLinks>()),
      isSingleton: false,
      isLazy: true,
    ),
  ];

  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [];
}
