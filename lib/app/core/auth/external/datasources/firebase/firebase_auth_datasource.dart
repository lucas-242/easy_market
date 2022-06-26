import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:market_lists/app/core/auth/external/datasources/firebase/errors/errors.dart';
import 'package:market_lists/app/core/auth/infra/datasources/auth_datasource.dart';
import 'package:market_lists/app/core/auth/infra/models/user_model.dart';

class FirebaseAuthDatasource implements AuthDatasource {
  final FirebaseAuth auth;

  FirebaseAuthDatasource(this.auth);

  @override
  Future<UserModel> getCurrentUser() async {
    final user = auth.currentUser;
    if (user == null) {
      throw FirebaseSignInFailure(message: 'There is no logged user');
    }
    return _getUserModel(user);
  }

  @override
  Future<UserModel> signInWithEmail(
      {required String email, required String password}) async {
    try {
      final result = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return _getUserModel(result.user!);
    } on FirebaseAuthException catch (error) {
      throw FirebaseSignInFailure.fromCode(error.code);
    } catch (error) {
      throw FirebaseSignInFailure();
    }
  }

  @override
  Future<UserModel> signInWithPhone({required String phone}) async {
    try {
      final credential = await _verifyPhoneNumber(phone: phone);
      final result = await auth.signInWithCredential(credential);
      return _getUserModel(result.user!);
    } on FirebaseAuthException catch (error) {
      throw FirebaseSignInFailure.fromCode(error.code);
    } catch (error) {
      throw FirebaseSignInFailure(message: error as String);
    }
  }

  Future<AuthCredential> _verifyPhoneNumber({required String phone}) async {
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
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
    return await completer.future;
  }

  @override
  Future<UserModel> verifyPhoneCode(
      {required String verificationId, required String code}) async {
    try {
      final credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: code);
      final result = await auth.signInWithCredential(credential);
      return _getUserModel(result.user!);
    } on FirebaseAuthException catch (error) {
      throw FirebaseSignInFailure.fromCode(error.code);
    } catch (error) {
      throw FirebaseSignInFailure();
    }
  }

  @override
  Future<void> signOut() async {
    try {
      return await auth.signOut();
    } on FirebaseAuthException catch (error) {
      throw FirebaseSignInFailure.fromCode(error.code);
    } catch (error) {
      throw FirebaseSignInFailure();
    }
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
