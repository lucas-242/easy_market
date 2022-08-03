import '../../domain/entities/deep_link_data.dart';

abstract class DeepLinksHandleDatasource {
  Stream<DeepLinkData?> listenInitialLink();
  Stream<DeepLinkData> listenBackgroudLinks();
}
