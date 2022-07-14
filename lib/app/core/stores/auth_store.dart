import 'package:flutter_modular/flutter_modular.dart';
import 'package:easy_market/app/modules/auth/domain/entities/user_info.dart';
import 'package:easy_market/app/modules/auth/domain/usecases/get_current_user.dart';
import 'package:easy_market/app/modules/auth/domain/usecases/listen_current_user.dart';
import 'package:easy_market/app/modules/auth/domain/usecases/sign_out.dart';
part 'auth_store.g.dart';

@Injectable(lazy: false)
class AuthStore {
  final ListenCurrentUser _listenCurrentUser;
  final GetCurrentUser _getCurrentUser;
  final SignOut _signOut;

  AuthStore(this._listenCurrentUser, this._getCurrentUser, this._signOut);

  UserInfo? user;

  bool get isLogged => user != null;

  Stream<UserInfo?> listenCurrentUser() {
    return _listenCurrentUser().map((response) {
      response.fold((l) => throw Exception(), (r) => user = r);
      return user;
    });
  }

  Future<bool> getCurrentUser() async {
    var result = await _getCurrentUser();
    return result.fold((l) => false, (r) {
      user = r;
      return true;
    });
  }

  Future<void> signOut() async {
    final result = await _signOut();
    result.fold((l) => l, (r) => user = null);
  }
}
