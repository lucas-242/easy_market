import 'package:market_lists/app/core/auth/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    super.id,
    required super.name,
    super.email,
    super.phone,
    super.imageUrl,
    super.createdAt,
    super.updatedAt,
  });

  User toUserImpl() => this;
}
