import 'dart:convert';

import 'package:market_lists/app/modules/grocery/domain/entities/grocery_list.dart';
import 'package:market_lists/app/modules/grocery/infra/models/grocery_model.dart';

class GroceryListModel extends GroceryList {
  @override
  List<GroceryModel> groceries;

  GroceryListModel({
    required super.name,
    required this.groceries,
    super.id,
    super.createdAt,
    super.updatedAt,
  });

  factory GroceryListModel.fromGroceryList(GroceryList groceryList) {
    return GroceryListModel(
      id: groceryList.id,
      name: groceryList.name,
      groceries: List<GroceryModel>.from(
          groceryList.groceries.map((x) => GroceryModel.fromGrocery(x))),
      createdAt: groceryList.createdAt,
      updatedAt: groceryList.updatedAt,
    );
  }

  Map<String, dynamic> toMapCreate() {
    return {
      'name': name,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  Map<String, dynamic> toMapUpdate() {
    return {
      'name': name,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'groceries': groceries.map((x) => x.toMap()).toList(),
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory GroceryListModel.fromMap(Map<String, dynamic> map) {
    return GroceryListModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      groceries: map['groceries'] != null
          ? List<GroceryModel>.from(
              map['groceries']?.map((x) => GroceryModel.fromMap(x)))
          : [],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory GroceryListModel.fromJson(String source) =>
      GroceryListModel.fromMap(json.decode(source));

  GroceryListModel copyWith({
    String? id,
    String? name,
    List<GroceryModel>? groceries,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return GroceryListModel(
      id: id ?? this.id,
      name: name ?? this.name,
      groceries: groceries ?? this.groceries,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
