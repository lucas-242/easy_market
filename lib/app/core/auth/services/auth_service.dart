import '../domain/entities/user_info.dart';
import '../domain/usecases/get_current_user.dart';
import '../domain/usecases/listen_current_user.dart';
import '../domain/usecases/sign_out.dart';
import 'package:flutter_modular/flutter_modular.dart';
part 'auth_service.g.dart';

@Injectable(lazy: false)
class AuthService {
  final ListenCurrentUser _listenCurrentUser;
  final GetCurrentUser _getCurrentUser;
  final SignOut _signOut;

  AuthService(this._listenCurrentUser, this._getCurrentUser, this._signOut);

  UserInfo? user;

  bool get isLogged => user != null;

  Stream<UserInfo?> listenCurrentUser() {
    return _listenCurrentUser().map((response) {
      response.fold((l) => throw l, (r) => user = r);
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
