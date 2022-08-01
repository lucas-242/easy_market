import '../domain/entities/deep_link_data.dart';
import '../domain/usecases/listen_background_links.dart';
import '../domain/usecases/listen_initial_link.dart';
import 'package:flutter_modular/flutter_modular.dart';
part 'routes_service.g.dart';

@Injectable(lazy: false)
class RoutesService {
  final ListenInitialLink _listenInitialLink;
  final ListenBackgroundLinks _listenBackgroundLinks;

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
