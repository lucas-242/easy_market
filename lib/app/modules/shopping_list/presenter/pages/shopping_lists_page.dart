import 'package:flutter/material.dart';

class ShoppingListsPage extends StatelessWidget {
  const ShoppingListsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('test'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(),
            Container(),
            Container(),
          ],
        ),
      ),
    );
  }
}
