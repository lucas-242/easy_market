import '../../../../errors/errors.dart';

class DeepLinkHandleFailure extends Failure {
  @override
  final String message;

  DeepLinkHandleFailure(this.message);
}
