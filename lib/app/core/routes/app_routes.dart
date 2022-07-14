abstract class AppRoutes {
  static String get main => '/';
  static String get lists => '/lists/';
  static String get listDetails => '/lists/details/';
  static String get auth => '/auth/';
  static String get signIn => '/auth/sign-in/';
  static String get signUp => '/auth/sign-up/';
  static String get sendPasswordResetEmail =>
      '/auth/send-password-reset-email/';
  static String get confirmPasswordReset => '/auth/confirm-password-reset/';

  static String lastPathInRoute(String appRoute) {
    final splitted = appRoute.split('/');
    final result = '/${splitted[splitted.length - 2]}/';
    return result;
  }
}
