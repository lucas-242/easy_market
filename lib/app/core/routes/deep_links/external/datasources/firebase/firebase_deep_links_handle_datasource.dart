import '../../../domain/entities/deep_link_data.dart';
import '../../../infra/datasources/deep_links_handle_datasource.dart';
import '../../../../utils/routes_utils.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class FirebaseDeepLinksHandleDatasource implements DeepLinksHandleDatasource {
  final FirebaseDynamicLinks _dynamicLinks;

  FirebaseDeepLinksHandleDatasource(this._dynamicLinks);

  @override
  Stream<DeepLinkData> listenBackgroudLinks() {
    return _dynamicLinks.onLink.map((dynamicLink) => DeepLinkData(
        path: RoutesUtils.lastPathInRoute(
            dynamicLink.link.queryParameters['continueUrl']!),
        parameters: dynamicLink.link.queryParameters));
  }

  @override
  Stream<DeepLinkData?> listenInitialLink() {
    return Stream.fromFuture(_dynamicLinks.getInitialLink()).map(
      (dynamicLink) => dynamicLink != null
          ? DeepLinkData(
              path: RoutesUtils.lastPathInRoute(
                  dynamicLink.link.queryParameters['continueUrl']!),
              parameters: dynamicLink.link.queryParameters)
          : null,
    );
  }
}
