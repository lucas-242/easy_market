import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_market/app/core/routes/deep_links.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_market/app/modules/auth/external/datasources/firebase/errors/errors.dart';
import 'package:easy_market/app/modules/auth/infra/datasources/auth_datasource.dart';
import 'package:easy_market/app/modules/auth/infra/models/user_model.dart';

class FirebaseAuthDatasource implements AuthDatasource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final String usersTable = 'users';

  FirebaseAuthDatasource(this.auth, this.firestore);

  @override
  Future<UserModel> getCurrentUser() async {
    final user = auth.currentUser;
    if (user == null) {
      throw FirebaseSignInFailure(message: 'There is no logged user');
    }
    return _getUserModel(user);
  }

  @override
  Stream<UserModel?> listenCurrentUser() {
    try {
      return auth
          .userChanges()
          .handleError((error) => throw FirebaseSignInFailure())
          .map((user) => user != null ? _getUserModel(user) : null);
    } on FirebaseAuthException catch (error) {
      throw FirebaseSignInFailure.fromCode(error.code);
    } catch (error) {
      throw FirebaseSignInFailure();
    }
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

  @override
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((credential) async => await _onCreateUser(credential, name))
          .catchError((error) => FirebaseSignUpFailure.fromCode(error.code));
    } on FirebaseException catch (error) {
      throw FirebaseSignUpFailure.fromCode(error.code);
    } catch (error) {
      throw FirebaseSignUpFailure();
    }
  }

  Future<void> _onCreateUser(UserCredential credential, String name) async {
    try {
      await _saveUserData(credential.user!, name);
    } catch (error) {
      credential.user!.delete();
      throw FirebaseSignUpFailure(message: 'Error to save user data');
    }
  }

  Future<void> _saveUserData(User user, String name) async {
    await firestore.collection(usersTable).add({
      'id': user.uid,
      'name': name,
      'email': user.email,
      'phone': '',
      'imageUrl': '',
      'createdAt':
          Timestamp.fromDate(user.metadata.creationTime ?? DateTime.now()),
      'updatedAt':
          Timestamp.fromDate(user.metadata.creationTime ?? DateTime.now())
    });
  }

  UserModel _getUserModel(User user) {
    return UserModel(
      id: user.uid,
      name: user.displayName ?? '',
      email: user.email,
      phone: user.phoneNumber,
      imageUrl: user.photoURL,
      createdAt: user.metadata.creationTime,
      updatedAt: user.metadata.creationTime,
    );
  }

  @override
  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await auth.sendPasswordResetEmail(
          email: email,
          actionCodeSettings: ActionCodeSettings(
            url: DeepLinks.resetPassword,
            handleCodeInApp: true,
            androidInstallApp: true,
            androidPackageName: 'com.easymarket.yourmarketlist',
          ));
    } on FirebaseException catch (error) {
      throw FirebaseSignUpFailure.fromCode(error.code);
    } catch (error) {
      throw FirebaseSignUpFailure();
    }
  }

  @override
  Future<void> confirmPasswordReset(
      {required String code, required String newPassword}) async {
    try {
      await auth.confirmPasswordReset(code: code, newPassword: newPassword);
    } on FirebaseException catch (error) {
      throw FirebaseSignUpFailure.fromCode(error.code);
    } catch (error) {
      throw FirebaseSignUpFailure();
    }
  }
}
