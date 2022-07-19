import 'package:easy_market/app/core/routes/utils/routes_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const simpleRoute = '/auth/';
  const route = '/auth/sign-in/';
  const httpRoute = 'https://test.com/auth/sign-in';

  test('Should return the unique path in route', () {
    final response = RoutesUtils.lastPathInRoute(simpleRoute);

    expect(response, '/auth/');
  });

  test('Should return last path in a route with multi paths', () {
    final response = RoutesUtils.lastPathInRoute(route);

    expect(response, '/sign-in/');
  });

  test('Should return last path in a http route', () {
    final response = RoutesUtils.lastPathInRoute(httpRoute);

    expect(response, '/sign-in/');
  });
}
