import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:market_lists/app/core/auth/domain/errors/errors.dart';
import 'package:market_lists/app/core/auth/external/datasources/firebase/firebase_auth_datasource.dart';
import 'package:market_lists/app/core/auth/infra/models/user_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../auth_mock_test.dart';
import 'firebase_auth_datasource_test.mocks.dart';

class FirebaseAuthTest extends Mock implements FirebaseAuth {
  @override
  Future<UserCredential> signInWithCredential(AuthCredential? credential) =>
      super.noSuchMethod(Invocation.method(#signInWithCredential, [credential]),
          returnValue: Future.value(userCredential));

  @override
  User get currentUser => super.noSuchMethod(Invocation.getter(#currentUser),
      returnValue: mockCurrentUser);

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
        verificationCompleted(phoneAuthCredential);
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

final phoneAuthCredential = MockPhoneAuthCredential();
final userCredential = MockUserCredential();
final mockCurrentUser = MockUser(
  isAnonymous: false,
  uid: userModel.id,
  email: userModel.email,
  displayName: userModel.name,
  phoneNumber: userModel.phone,
);

@GenerateMocks([FirebaseAuthTest, PhoneAuthCredential, UserCredential])
void main() {
  MockUser user = MockUser(
    isAnonymous: false,
    uid: userModel.id,
    email: userModel.email,
    displayName: userModel.name,
    phoneNumber: userModel.phone,
  );
  late FirebaseAuth auth;
  late FirebaseAuthDatasource datasource;

  void setDatasource({bool signedIn = false}) {
    auth = MockFirebaseAuth(mockUser: user, signedIn: signedIn);
    datasource = FirebaseAuthDatasource(auth);
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
    test('Should login with phone', () async {
      final auth = FirebaseAuthTest();
      datasource = FirebaseAuthDatasource(auth);
      when(auth.signInWithCredential(any))
          .thenAnswer((_) async => userCredential);
      when(userCredential.user).thenAnswer((_) => mockCurrentUser);
      final result = await datasource.signInWithPhone(phone: "0");

      expectResultIsUserModel(result);
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

    test('Should throw GetCurrentUserFailure when user is not logged in',
        () async {
      setDatasource();
      expect(
          datasource.getCurrentUser(), throwsA(isA<GetCurrentUserFailure>()));
    });
  });

  group('Logout', () {
    test('Should logout', () async {
      setDatasource(signedIn: true);
      expect(datasource.signOut(), completes);
    });
  });
}
