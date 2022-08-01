import 'package:easy_market/app/shared/utils/item_type_util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../shared/widgets/custom_slidable/custom_slidable.dart';
import '../../domain/entities/item.dart';

class ItemCard extends StatelessWidget {
  final Item item;
  final void Function(Item) onTapUpdate;
  final void Function(Item) onTapDelete;
  const ItemCard({
    Key? key,
    required this.item,
    required this.onTapUpdate,
    required this.onTapDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomSlidable(
      leftPanel: true,
      rightPanel: true,
      onLeftSlide: () => onTapUpdate(item),
      onRightSlide: () => onTapDelete(item),
      child: _Body(item: item),
    );
  }
}

class _Body extends StatelessWidget {
  final Item item;
  const _Body({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.name),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            item.quantity.toString(),
            textAlign: TextAlign.end,
          ),
          const SizedBox(height: 5.0),
          Text(
            item.price != null
                ? NumberFormat.simpleCurrency().format(item.price)
                : '',
            textAlign: TextAlign.end,
          ),
        ],
      ),
      subtitle:
          Text(ItemTypeUtil.stringfy(itemType: item.type, context: context)),
    );
  }
}
