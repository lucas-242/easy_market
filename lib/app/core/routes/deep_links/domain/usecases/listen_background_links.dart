import 'package:dartz/dartz.dart';
import 'package:easy_market/app/core/errors/errors.dart';
import 'package:easy_market/app/core/routes/deep_links/domain/entities/deep_link_data.dart';
import 'package:easy_market/app/core/routes/deep_links/domain/repositories/deep_links_handle_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';

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
