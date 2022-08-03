import '../../domain/entities/deep_link_data.dart';
import '../../../../errors/errors.dart';
import 'package:dartz/dartz.dart';
import '../../domain/errors/errors.dart';
import '../../domain/repositories/deep_links_handle_repository.dart';
import '../datasources/deep_links_handle_datasource.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'deep_links_handle_repository_impl.g.dart';

@Injectable(singleton: false)
class DeepLinksHandleRepositoryImpl implements DeepLinksHandleRepository {
  final DeepLinksHandleDatasource _datasource;

  DeepLinksHandleRepositoryImpl(this._datasource);

  @override
  Stream<Either<Failure, DeepLinkData>> listenBackgroudLinks() {
    try {
      return _datasource
          .listenBackgroudLinks()
          .handleError(
              (error) => Left(DeepLinkHandleFailure('Fail to handle a link.')))
          .map((deepLink) => Right(deepLink));
    } on Failure catch (error) {
      return Stream.value(Left(DeepLinkHandleFailure(error.message)));
    } catch (error) {
      return Stream.value(
          Left(DeepLinkHandleFailure('Fail to handle a link.')));
    }
  }

  @override
  Stream<Either<Failure, DeepLinkData?>> listenInitialLink() {
    try {
      return _datasource
          .listenInitialLink()
          .handleError((error) =>
              Left(DeepLinkHandleFailure('Fail to handle initial link.')))
          .map((deepLink) =>
              deepLink != null ? Right(deepLink) : const Right(null));
    } on Failure catch (error) {
      return Stream.value(Left(DeepLinkHandleFailure(error.message)));
    } catch (error) {
      return Stream.value(
          Left(DeepLinkHandleFailure('Fail to handle initial link.')));
    }
  }
}
