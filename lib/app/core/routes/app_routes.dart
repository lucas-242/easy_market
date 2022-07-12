abstract class AppRoutes {
  static String get main => '/';
  static String get lists => '/lists/';
  static String get listDetails => '/lists/details/';
  static String get login => '/login/';
  static String get signIn => '/login/sign-in/';
  static String get signUp => '/login/sign-up/';
  static String get sendPasswordResetEmail =>
      '/login/send-password-reset-email/';
  static String get confirmPasswordReset => '/login/confirm-password-reset/';

  static String lastPathInRoute(String appRoute) {
    final splitted = appRoute.split('/');
    final result = '/${splitted[splitted.length - 2]}/';
    return result;
  }
}
