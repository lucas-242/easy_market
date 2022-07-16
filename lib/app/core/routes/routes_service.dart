import 'package:easy_market/app/core/routes/deep_links/domain/entities/deep_link_data.dart';
import 'package:easy_market/app/core/routes/deep_links/domain/usecases/listen_background_links.dart';
import 'package:easy_market/app/core/routes/deep_links/domain/usecases/listen_initial_link.dart';
import 'package:flutter_modular/flutter_modular.dart';
part 'routes_service.g.dart';

@Injectable(lazy: false)
class RoutesService {
  final ListenInitialLink _listenInitialLink;
  final ListenBackgroundLinks _listenBackgroundLinks;

  DeepLinkData? _deepLinkData;
  DeepLinkData? get deepLinkData => _deepLinkData;

  RoutesService(this._listenInitialLink, this._listenBackgroundLinks);

  Stream<DeepLinkData?> listenInitialLink() {
    return _listenInitialLink()
        .map((response) => response.fold((l) => throw l, (r) => r));
  }

  Stream<DeepLinkData> listenBackgroundLinks() {
    return _listenBackgroundLinks()
        .map((response) => response.fold((l) => throw l, (r) => r));
  }
}
