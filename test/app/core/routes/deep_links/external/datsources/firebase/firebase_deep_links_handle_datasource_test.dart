import 'package:easy_market/app/core/routes/deep_links/external/datasources/firebase/firebase_deep_links_handle_datasource.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../deep_links_mock_test.dart';

final successData = PendingDynamicLinkData(
    link: Uri.parse('https://test.com/path?continueUrl=testPath'));

class MockFirebaseDynamicLinks extends Mock implements FirebaseDynamicLinks {
  @override
  Stream<PendingDynamicLinkData> get onLink =>
      super.noSuchMethod(Invocation.getter(#onLink),
          returnValue: Stream.value(successData));

  @override
  Future<PendingDynamicLinkData?> getInitialLink() {
    return super.noSuchMethod(Invocation.method(#getInitialLink, null),
        returnValue: Future.value(successData));
  }
}

void main() {
  final FirebaseDynamicLinks dynamicLinks = MockFirebaseDynamicLinks();
  final datasource = FirebaseDeepLinksHandleDatasource(dynamicLinks);

  test('Should listen to initial link', () {
    when(dynamicLinks.getInitialLink())
        .thenAnswer((_) async => Future.value(successData));

    final result = datasource.listenInitialLink();
    result.listen((event) {
      expect(event!.path, deepLinkData.path);
    });
  });

  test('Should listen to background links', () {
    when(dynamicLinks.onLink).thenAnswer((_) => Stream.value(successData));

    final result = datasource.listenBackgroudLinks();
    result.listen((event) {
      expect(event.path, deepLinkData.path);
    });
  });
}
