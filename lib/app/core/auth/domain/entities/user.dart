class User {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String? password;
  final String? imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    this.id = '',
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.password,
    this.imageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();
}
