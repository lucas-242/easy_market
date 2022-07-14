import 'package:flutter_test/flutter_test.dart';
import 'package:easy_market/app/core/routes/app_routes.dart';

void main() {
  const simpleRoute = '/login/';
  const route = '/login/sign-in/';

  test('Should return the unique path in route', () {
    final response = AppRoutes.lastPathInRoute(simpleRoute);

    expect(response, '/login/');
  });

  test('Should return last path', () {
    final response = AppRoutes.lastPathInRoute(route);

    expect(response, '/sign-in/');
  });
}
