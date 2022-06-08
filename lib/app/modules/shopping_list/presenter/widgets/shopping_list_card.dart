import 'package:flutter/material.dart';
import 'package:market_lists/app/modules/shopping_list/shopping_list.dart';
import 'package:market_lists/app/shared/themes/typography_utils.dart';

class ShoppingListCard extends StatelessWidget {
  final ShoppingList shoppingList;
  final Function(String) onTap;
  const ShoppingListCard(
      {Key? key, required this.shoppingList, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Material(
        child: InkWell(
          onTap: () => onTap(shoppingList.id),
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Text(
                shoppingList.name,
                style: context.bodyLarge,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
