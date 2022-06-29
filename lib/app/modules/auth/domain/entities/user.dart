import 'package:market_lists/app/modules/auth/domain/entities/user_info.dart';

class User implements UserInfo {
  @override
  final String id;
  @override
  final String name;
  @override
  final String email;
  @override
  final String phone;
  @override
  final String? imageUrl;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  User({
    String? id,
    required this.name,
    String? email,
    String? phone,
    this.imageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : id = id ?? '',
        email = email ?? '',
        phone = phone ?? '',
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();
}
