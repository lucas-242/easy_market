import 'package:flutter/material.dart';
import '../../../../shared/widgets/custom_slidable/custom_slidable.dart';
import '../../shopping_list.dart';

class ShoppingListCard extends StatelessWidget {
  final ShoppingList shoppingList;
  final Function(String) onTap;
  final void Function(ShoppingList) onTapUpdate;
  final void Function(ShoppingList) onTapDelete;
  const ShoppingListCard({
    Key? key,
    required this.shoppingList,
    required this.onTapUpdate,
    required this.onTapDelete,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomSlidable(
      leftPanel: true,
      rightPanel: true,
      onLeftSlide: () => onTapUpdate(shoppingList),
      onRightSlide: () => onTapDelete(shoppingList),
      child: _Body(
        shoppingList: shoppingList,
        onTap: onTap,
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final ShoppingList shoppingList;
  final Function(String) onTap;
  const _Body({
    Key? key,
    required this.shoppingList,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () => onTap(shoppingList.id),
        child: SizedBox(
          width: double.infinity,
          child: ListTile(
            title: Text(shoppingList.name),
            trailing: const Icon(Icons.chevron_right),
          ),
        ),
      ),
    );
  }
}
