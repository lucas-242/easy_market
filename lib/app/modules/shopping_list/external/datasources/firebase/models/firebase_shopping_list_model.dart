import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_market/app/modules/shopping_list/infra/models/item_model.dart';
import 'package:easy_market/app/modules/shopping_list/infra/models/shopping_list_model.dart';

import '../../../../domain/entities/item.dart';

class FirebaseShoppingListModel extends ShoppingListModel {
  FirebaseShoppingListModel({
    required super.name,
    required super.items,
    super.id,
    super.createdAt,
    super.updatedAt,
    required super.owner,
    super.users,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'items': items.map((x) => ItemModel.fromItem(x).toMap()).toList(),
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'owner': owner,
      'users': users,
    };
  }

  Map<String, dynamic> toCreate() {
    return {
      'name': name,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'owner': owner,
      'users': [owner],
    };
  }

  Map<String, dynamic> toUpdate() {
    return {
      'name': name,
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  factory FirebaseShoppingListModel.fromMap(Map<String, dynamic> map) {
    return FirebaseShoppingListModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      items: map['items'] != null
          ? List<ItemModel>.from(map['items']?.map((x) => ItemModel.fromMap(x)))
          : [],
      createdAt: map['createdAt'].toDate(),
      updatedAt: map['updatedAt'].toDate(),
      owner: map['owner'],
      users: map['users'] != null ? List<String>.from(map['users']) : [],
    );
  }

  factory FirebaseShoppingListModel.fromJson(String source) =>
      FirebaseShoppingListModel.fromMap(json.decode(source));

  factory FirebaseShoppingListModel.fromShoppingListModel(
          ShoppingListModel shoppingListModel) =>
      FirebaseShoppingListModel(
        id: shoppingListModel.id,
        name: shoppingListModel.name,
        items: shoppingListModel.items,
        createdAt: shoppingListModel.createdAt,
        updatedAt: shoppingListModel.updatedAt,
        owner: shoppingListModel.owner,
        users: shoppingListModel.users,
      );

  @override
  FirebaseShoppingListModel copyWith(
      {String? id,
      String? name,
      List<Item>? items,
      DateTime? createdAt,
      DateTime? updatedAt,
      String? owner,
      List<String>? users}) {
    return FirebaseShoppingListModel(
      id: id ?? this.id,
      name: name ?? this.name,
      items: items ?? this.items,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      owner: owner ?? this.owner,
      users: users ?? this.users,
    );
  }
}
