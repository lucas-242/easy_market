import 'package:flutter_modular/flutter_modular.dart';
import 'package:market_lists/app/modules/auth/domain/entities/user_info.dart';
import 'package:market_lists/app/modules/auth/domain/usecases/get_current_user.dart';
import 'package:market_lists/app/modules/auth/domain/usecases/sign_out.dart';
part 'auth_store.g.dart';

@Injectable(lazy: false)
class AuthStore {
  final GetCurrentUser _getCurrentUser;
  final SignOut _signOut;

  AuthStore(this._getCurrentUser, this._signOut);

  UserInfo? user;

  bool get isLogged => user != null;

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
