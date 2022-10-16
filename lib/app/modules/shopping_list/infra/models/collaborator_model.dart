import 'dart:convert';

import '../../domain/entities/collaborator.dart';

class CollaboratorModel extends Collaborator {
  CollaboratorModel({
    String id = "",
    required String name,
    required String email,
    bool isAlreadyUser = true,
  }) : super(
          id: id,
          name: name,
          email: email,
          isAlreadyUser: isAlreadyUser,
        );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }

  factory CollaboratorModel.fromMap(Map<String, dynamic> map) {
    return CollaboratorModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CollaboratorModel.fromJson(String source) =>
      CollaboratorModel.fromMap(json.decode(source));

  CollaboratorModel copyWith({
    String? id,
    String? name,
    String? email,
    bool? isAlreadyUser,
  }) {
    return CollaboratorModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      isAlreadyUser: isAlreadyUser ?? this.isAlreadyUser,
    );
  }
}
