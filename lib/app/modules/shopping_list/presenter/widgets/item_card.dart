import 'package:easy_market/app/shared/themes/themes.dart';
import 'package:easy_market/app/shared/utils/item_type_util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../shared/widgets/custom_slidable/custom_slidable.dart';
import '../../domain/entities/item.dart';

class ItemCard extends StatelessWidget {
  final Item item;
  final void Function(Item) onTapUpdate;
  final void Function(Item) onTapDelete;
  final void Function(Item) onCheck;
  const ItemCard({
    Key? key,
    required this.item,
    required this.onTapUpdate,
    required this.onTapDelete,
    required this.onCheck,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomSlidable(
      leftPanel: true,
      rightPanel: true,
      onLeftSlide: () => onTapUpdate(item),
      onRightSlide: () => onTapDelete(item),
      child: _Body(item: item, onCheck: onCheck),
    );
  }
}

class _Body extends StatelessWidget {
  final Item item;
  final void Function(Item) onCheck;
  const _Body({Key? key, required this.item, required this.onCheck})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: _Title(item: item),
      contentPadding: const EdgeInsets.only(right: 25, left: 10),
      subtitle: _Subtitle(item: item),
      leading: _Leading(
        item: item,
        onCheck: onCheck,
      ),
      // trailing: _Trailing(item: item),
    );
  }
}

class _Title extends StatelessWidget {
  final Item item;
  const _Title({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          item.name,
          style: item.isChecked
              ? context.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.lineThrough,
                  color: context.theme.disabledColor,
                )
              : context.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          '${item.quantity} u',
          textAlign: TextAlign.end,
          style: context.bodyLarge!.copyWith(
            fontWeight: FontWeight.bold,
            color: context.theme.disabledColor,
            decoration: item.isChecked
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
      ],
    );
  }
}

class _Subtitle extends StatelessWidget {
  final Item item;
  const _Subtitle({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle.merge(
      style: context.bodyLarge!.copyWith(
        color: context.theme.disabledColor,
        decoration:
            item.isChecked ? TextDecoration.lineThrough : TextDecoration.none,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(ItemTypeUtil.stringfy(item.type)),
            Text(
              item.price != null
                  ? NumberFormat.simpleCurrency().format(item.price)
                  : '',
              textAlign: TextAlign.end,
            ),
          ],
        ),
      ),
    );
  }
}

class _Leading extends StatelessWidget {
  final Item item;
  final void Function(Item) onCheck;
  const _Leading({Key? key, required this.item, required this.onCheck})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      value: item.isChecked,
      onChanged: (value) => onCheck(item),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      activeColor: context.colorsScheme.primary,
      checkColor: context.colorsScheme.onPrimary,
    );
  }
}
