import 'package:easy_market/app/core/routes/deep_links/domain/entities/deep_link_data.dart';

abstract class DeepLinksHandleDatasource {
  Stream<DeepLinkData?> listenInitialLink();
  Stream<DeepLinkData> listenBackgroudLinks();
}
