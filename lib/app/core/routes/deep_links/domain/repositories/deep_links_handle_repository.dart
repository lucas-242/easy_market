import 'package:dartz/dartz.dart';
import 'package:easy_market/app/core/errors/errors.dart';
import 'package:easy_market/app/core/routes/deep_links/domain/entities/deep_link_data.dart';

abstract class DeepLinksHandleRepository {
  Stream<Either<Failure, DeepLinkData?>> listenInitialLink();
  Stream<Either<Failure, DeepLinkData>> listenBackgroudLinks();
}
