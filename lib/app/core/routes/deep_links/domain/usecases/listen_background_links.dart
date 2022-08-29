import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../errors/errors.dart';
import '../entities/deep_link_data.dart';
import '../repositories/deep_links_handle_repository.dart';

part 'listen_background_links.g.dart';

abstract class ListenBackgroundLinks {
  Stream<Either<Failure, DeepLinkData>> call();
}

@Injectable(singleton: false)
class ListenBackgroundLinksImpl implements ListenBackgroundLinks {
  final DeepLinksHandleRepository _repository;

  ListenBackgroundLinksImpl(this._repository);

  @override
  Stream<Either<Failure, DeepLinkData>> call() {
    return _repository.listenBackgroudLinks();
  }
}
