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
            FloatingActionButton(onPressed: (() => null)),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'home',
          ),
          BottomNavigationBarItem(
              activeIcon: Icon(Icons.account_balance_wallet),
              icon: Icon(Icons.account_balance_wallet_outlined),
              label: 'wallet'),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'trades',
          ),
        ],
      ),
    );
  }
}
