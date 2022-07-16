abstract class RoutesUtils {
  static String lastPathInRoute(String route) {
    final splitted = route.split('/');
    final path = splitted.lastWhere((e) => e.isNotEmpty && e != '/');
    final result = '/$path/';
    return result;
  }
}
