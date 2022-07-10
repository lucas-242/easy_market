import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:market_lists/app/modules/auth/external/datasources/firebase/errors/errors.dart';
import 'package:market_lists/app/modules/auth/external/datasources/firebase/firebase_auth_datasource.dart';
import 'package:market_lists/app/modules/auth/infra/models/user_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../auth_mock_test.dart';
import 'firebase_auth_datasource_test.mocks.dart';

class MockCustomFirebaseAuth extends Mock implements FirebaseAuth {
  @override
  Future<UserCredential> signInWithCredential(AuthCredential? credential) =>
      super.noSuchMethod(Invocation.method(#signInWithCredential, [credential]),
          returnValue: Future.value(mockUserCredential));

  @override
  User get currentUser => super
      .noSuchMethod(Invocation.getter(#currentUser), returnValue: mockUser);

  @override
  Future<void> verifyPhoneNumber(
      {String? autoRetrievedSmsCodeForTesting,
      required void Function(String) codeAutoRetrievalTimeout,
      required void Function(String, int?) codeSent,
      int? forceResendingToken,
      required String phoneNumber,
      Duration? timeout,
      required void Function(PhoneAuthCredential) verificationCompleted,
      required void Function(FirebaseAuthException) verificationFailed}) async {
    Future.delayed(const Duration(milliseconds: 800)).then((value) {
      if (phoneNumber == "0") {
        verificationCompleted(mockPhoneAuthCredential);
      } else if (phoneNumber == "1") {
        verificationFailed(FirebaseAuthException(code: ''));
      } else if (phoneNumber == "2") {
        codeSent("dwf32f", 1);
      } else if (phoneNumber == "3") {
        codeAutoRetrievalTimeout("dwf32f");
        codeSent("dwf32f", 1);
      }
    });
    return;
  }
}

final mockPhoneAuthCredential = MockPhoneAuthCredential();
final mockUserCredential = MockUserCredential();
final mockUser = MockUser(
  isAnonymous: false,
  uid: userModel.id,
  email: userModel.email,
  displayName: userModel.name,
  phoneNumber: userModel.phone,
);

@GenerateMocks([PhoneAuthCredential, UserCredential])
void main() {
  late FirebaseAuth auth;
  late FirebaseFirestore database;
  late FirebaseAuthDatasource datasource;

  void setDatasource({bool signedIn = false}) {
    auth = MockFirebaseAuth(mockUser: mockUser, signedIn: signedIn);
    database = FakeFirebaseFirestore();
    datasource = FirebaseAuthDatasource(auth, database);
  }

  void expectResultIsUserModel(UserModel result) {
    expect(result.id, isNotEmpty);
    expect(result.name, userModel.name);
    expect(result.email, userModel.email);
    expect(result.phone, userModel.phone);
  }

  group('Sign in by Email', () {
    const passwordToLogin = '123456';

    test('Should login with email', () async {
      setDatasource();
      final result = await datasource.signInWithEmail(
          email: userModel.email, password: passwordToLogin);

      expectResultIsUserModel(result);
    });
  });

  group('Sign in by phone', () {
    setUp(() {
      final auth = MockCustomFirebaseAuth();
      datasource = FirebaseAuthDatasource(auth, database);
      when(auth.signInWithCredential(any))
          .thenAnswer((_) async => mockUserCredential);
      when(mockUserCredential.user).thenAnswer((_) => mockUser);
    });

    test('Should sign in with phone', () async {
      final result = await datasource.signInWithPhone(phone: "0");
      expectResultIsUserModel(result);
    });

    test('Should throw FirebaseSignInFailure if there is an error', () async {
      expect(datasource.signInWithPhone(phone: "1"),
          throwsA(isA<FirebaseSignInFailure>()));
    });

    test(
        'Should throw FirebaseSignInFailure if code was not retrieved automatically',
        () async {
      expect(datasource.signInWithPhone(phone: "2"),
          throwsA(isA<FirebaseSignInFailure>()));
    });
  });

  group('Verify phone code', () {
    const String code = 'abc123';
    const String verificationId = '123456';

    test('Should login with phone code', () async {
      setDatasource();
      final result = await datasource.verifyPhoneCode(
          code: code, verificationId: verificationId);

      expectResultIsUserModel(result);
    });
  });

  group('Get current user', () {
    test('Should Get current user', () async {
      setDatasource(signedIn: true);
      final result = await datasource.getCurrentUser();

      expectResultIsUserModel(result);
    });

    test('Should throw FirebaseSignInFailure when user is not logged in',
        () async {
      setDatasource();
      expect(
          datasource.getCurrentUser(), throwsA(isA<FirebaseSignInFailure>()));
    });
  });

  group('Listen current user', () {
    test('Should return current user', () {
      setDatasource(signedIn: true);
      final result = datasource.listenCurrentUser();

      result.listen((event) {
        expectResultIsUserModel(event!);
      });
    });

    test('Should return null when user is not logged in', () {
      setDatasource();
      final result = datasource.listenCurrentUser();

      result.listen((event) {
        expect(event, isNull);
      });
    });
  });

  group('Logout', () {
    test('Should logout', () async {
      setDatasource(signedIn: true);
      expect(datasource.signOut(), completes);
    });
  });

  group('Sign up', () {
    test('Should Sign up', () async {
      setDatasource(signedIn: false);

      expect(
          datasource.signUp(
            email: userModel.email,
            name: userModel.name,
            password: '123456',
          ),
          completes);
    });
  });
}
