import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:market_lists/app/core/auth/domain/errors/errors.dart';
import 'package:market_lists/app/core/auth/external/datasources/firebase/errors/errors.dart';
import 'package:market_lists/app/core/auth/infra/datasources/auth_datasource.dart';
import 'package:market_lists/app/core/auth/infra/models/user_model.dart';

class FirebaseAuthDatasource implements AuthDatasource {
  final FirebaseAuth auth;

  FirebaseAuthDatasource(this.auth);

  @override
  Future<UserModel> getCurrentUser() async {
    final user = auth.currentUser;

    if (user == null) throw GetCurrentUserFailure('There is no logged user');

    return _getUserModel(user);
  }

  @override
  Future<UserModel> signInWithEmail(
      {required String email, required String password}) async {
    try {
      final result = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return _getUserModel(result.user!);
    } on FirebaseAuthException catch (e) {
      throw FirebaseSignInWithEmailFailure.fromCode(e.code);
    } catch (_) {
      throw FirebaseSignInWithEmailFailure();
    }
  }

  @override
  Future<UserModel> signInWithPhone({required String phone}) async {
    final completer = Completer<AuthCredential>();
    await auth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (auth) {
          completer.complete(auth);
        },
        verificationFailed: (error) {
          completer.completeError(error);
        },
        codeSent: (String verificationId, int? forceResendingToken) {
          completer.completeError('Code was not retrieved automatically');
        },
        codeAutoRetrievalTimeout: (String verificationId) {});

    final credential = await completer.future;
    final result = await auth.signInWithCredential(credential);
    return _getUserModel(result.user!);
  }

  @override
  Future<UserModel> verifyPhoneCode(
      {required String verificationId, required String code}) async {
    final credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: code);
    final result = await auth.signInWithCredential(credential);
    return _getUserModel(result.user!);
  }

  @override
  Future<void> signOut() async {
    return await auth.signOut();
  }

  UserModel _getUserModel(User user) {
    return UserModel(
      id: user.uid,
      name: user.displayName!,
      email: user.email,
      phone: user.phoneNumber,
      imageUrl: user.photoURL,
      createdAt: user.metadata.creationTime,
      updatedAt: user.metadata.creationTime,
    );
  }
}
