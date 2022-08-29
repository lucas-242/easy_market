import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'domain/usecases/listen_background_links.dart';
import 'domain/usecases/listen_initial_link.dart';
import 'external/datasources/firebase/firebase_deep_links_handle_datasource.dart';
import 'infra/repositories/deep_links_handle_repository_impl.dart';
import 'services/routes_service.dart';

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
