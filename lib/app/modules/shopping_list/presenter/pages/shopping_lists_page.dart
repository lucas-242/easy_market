import 'package:flutter/material.dart';
import 'package:market_lists/app/modules/shopping_list/presenter/widgets/shopping_list_card.dart';
import 'package:market_lists/app/modules/shopping_list/shopping_list.dart';
import 'package:market_lists/app/shared/themes/typography_utils.dart';

class ShoppingListsPage extends StatelessWidget {
  const ShoppingListsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome John',
          style: context.titleLarge,
        ),
        toolbarHeight: kToolbarHeight * 1.3,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: CircleAvatar(
              backgroundColor: theme.colorScheme.tertiary,
              child: const Icon(Icons.person),
            ),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => ShoppingListCard(
          shoppingList:
              ShoppingList(id: index.toString(), name: 'List ${index + 1}'),
          onTap: (id) {},
        ),
      ),
    );
  }
}
