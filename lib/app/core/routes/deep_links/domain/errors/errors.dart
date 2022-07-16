import 'package:easy_market/app/core/errors/errors.dart';

class DeepLinkHandleFailure extends Failure {
  @override
  final String message;

  DeepLinkHandleFailure(this.message);
}
