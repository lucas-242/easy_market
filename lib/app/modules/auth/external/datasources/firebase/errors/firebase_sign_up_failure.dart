import 'package:easy_market/app/core/errors/errors.dart';

/// {@template firebase_sign_up_failure}
/// Thrown during the sign up process if a failure occurs.
/// {@endtemplate}
class FirebaseSignUpFailure implements Failure {
  @override
  final String message;

  /// {@macro firebase_sign_up_failure}
  FirebaseSignUpFailure({this.message = 'An unknown exception occurred.'});

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory FirebaseSignUpFailure.fromCode(String code) {
    switch (code) {
      case 'email-already-in-use:':
        return FirebaseSignUpFailure(
          message: 'There is already an account with this credential.',
        );
      case 'operation-not-allowed':
        return FirebaseSignUpFailure(
          message:
              'You can not create an account with this method. Please try another account or contact support for help.',
        );
      case 'invalid-email':
        return FirebaseSignUpFailure(
          message: 'Email is not valid or badly formatted.',
        );
      case 'weak-password':
        return FirebaseSignUpFailure(
          message: 'Password is too weak. Please, try a different one.',
        );
      default:
        return FirebaseSignUpFailure();
    }
  }
}
