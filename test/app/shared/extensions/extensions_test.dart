import 'package:flutter_test/flutter_test.dart';
import 'package:market_lists/app/shared/extensions/extensions.dart';

enum Test { a, b, abc }

void main() {
  group('Enum extensions', () {
    test('Should convert enum to string', () {
      var mock = Test.abc;
      var result = mock.toShortString();

      expect(result, 'abc');
    });

    test('Should convert enum? to string', () {
      Test? mock;
      var result = mock.toShortString();

      expect(result, isNull);
    });
  });
}
