import 'package:flutter/material.dart';
import 'package:easy_market/app/modules/shopping_list/shopping_list.dart';
import 'package:easy_market/app/shared/themes/typography_utils.dart';

class ShoppingListDetailsPage extends StatefulWidget {
  final String shoppingListId;
  const ShoppingListDetailsPage({Key? key, required this.shoppingListId})
      : super(key: key);

  @override
  State<ShoppingListDetailsPage> createState() =>
      _ShoppingListDetailsPageState();
}

class _ShoppingListDetailsPageState extends State<ShoppingListDetailsPage> {
  late ShoppingList shoppingList;

  @override
  void initState() {
    // TODO: listen to shoppingList and groceryLists
    shoppingList = ShoppingList(
      id: widget.shoppingListId,
      name: 'List ${widget.shoppingListId}',
      items: List<Item>.generate(
        20,
        (index) => Item(
            id: index.toString(),
            name: 'Item ${index + 1}',
            quantity: index * 2),
      ),
      owner: '',
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          shoppingList.name,
          style: context.titleLarge,
        ),
        actions: const [
          IconButton(onPressed: null, icon: Icon(Icons.filter_alt)),
          IconButton(onPressed: null, icon: Icon(Icons.more_horiz))
        ],
      ),
      body: ListView.builder(
        itemCount: shoppingList.items.length,
        itemBuilder: ((context, index) => ListTile(
              title: Text(shoppingList.items[index].name),
              trailing: Text(shoppingList.items[index].quantity.toString()),
            )),
      ),
    );
  }
}
