import 'dart:convert';

import '../../domain/entities/collaborator.dart';

class CollaboratorModel extends Collaborator {
  CollaboratorModel(super.id, super.name, super.email);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }

  factory CollaboratorModel.fromMap(Map<String, dynamic> map) {
    return CollaboratorModel(
      map['id'] ?? '',
      map['name'] ?? '',
      map['email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CollaboratorModel.fromJson(String source) =>
      CollaboratorModel.fromMap(json.decode(source));

  CollaboratorModel copyWith({
    String? id,
    String? name,
    String? email,
  }) {
    return CollaboratorModel(
      id ?? this.id,
      name ?? this.name,
      email ?? this.email,
    );
  }
}
