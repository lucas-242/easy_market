import 'package:market_lists/app/core/auth/domain/entities/user_impl.dart';

class UserModel extends User {
  UserModel({required super.name, required super.email, required super.phone});

  User toUserImpl() => this;
}
