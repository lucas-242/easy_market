import 'package:dartz/dartz.dart';
import 'package:easy_market/app/core/errors/errors.dart';
import 'package:easy_market/app/core/routes/deep_links/domain/entities/deep_link_data.dart';
import 'package:easy_market/app/core/routes/deep_links/domain/repositories/deep_links_handle_repository.dart';
import 'package:easy_market/app/core/routes/deep_links/infra/datasources/deep_links_handle_datasource.dart';
import 'package:mockito/annotations.dart';

final deepLinkData =
    DeepLinkData(path: '/testPath/', parameters: {'code': 'test'});

@GenerateMocks([
  DeepLinksHandleRepository,
  DeepLinksHandleDatasource,
  Stream<Either<Failure, DeepLinkData>>,
])
void main() {}
