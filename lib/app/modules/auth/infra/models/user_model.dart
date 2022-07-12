import 'package:market_lists/app/modules/auth/domain/entities/user.dart';

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

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? imageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
