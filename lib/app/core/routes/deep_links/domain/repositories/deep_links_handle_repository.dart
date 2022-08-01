import 'package:dartz/dartz.dart';
import '../../../../errors/errors.dart';
import '../entities/deep_link_data.dart';

abstract class DeepLinksHandleRepository {
  Stream<Either<Failure, DeepLinkData?>> listenInitialLink();
  Stream<Either<Failure, DeepLinkData>> listenBackgroudLinks();
}
