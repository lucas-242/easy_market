import 'package:flutter/cupertino.dart';

import '../extensions/extensions.dart';
import '../../modules/shopping_list/shopping_list.dart';

abstract class ItemTypeUtil {
  static ItemType? toItemType(String text) {
    if (_isEqual(text, ItemType.breadAndBreadSpreads)) {
      return ItemType.breadAndBreadSpreads;
    } else if (_isEqual(text, ItemType.careProducts)) {
      return ItemType.careProducts;
    } else if (_isEqual(text, ItemType.cleaningProducts)) {
      return ItemType.cleaningProducts;
    } else if (_isEqual(text, ItemType.dairy)) {
      return ItemType.dairy;
    } else if (_isEqual(text, ItemType.dryGoods)) {
      return ItemType.dryGoods;
    } else if (_isEqual(text, ItemType.frozen)) {
      return ItemType.frozen;
    } else if (_isEqual(text, ItemType.meatAndFish)) {
      return ItemType.meatAndFish;
    } else if (_isEqual(text, ItemType.petShop)) {
      return ItemType.petShop;
    } else if (_isEqual(text, ItemType.snacks)) {
      return ItemType.snacks;
    } else if (_isEqual(text, ItemType.vegetablesAndFruits)) {
      return ItemType.vegetablesAndFruits;
    } else {
      return null;
    }
  }

  static bool _isEqual(String text, ItemType itemType) {
    if (text.compareTo(itemType.toShortString()) == 0) {
      return true;
    }

    return false;
  }

  static String stringfy({
    required ItemType? itemType,
    required BuildContext context,
  }) {
    switch (itemType) {
      case null:
        return '';
      case ItemType.breadAndBreadSpreads:
        return context.appLocalization.breadAndBreadSpreads;
      case ItemType.careProducts:
        return context.appLocalization.careProducts;
      case ItemType.cleaningProducts:
        return context.appLocalization.cleaningProducts;
      case ItemType.dairy:
        return context.appLocalization.dairy;
      case ItemType.dryGoods:
        return context.appLocalization.dryGoods;
      case ItemType.frozen:
        return context.appLocalization.frozen;
      case ItemType.meatAndFish:
        return context.appLocalization.meatAndFish;
      case ItemType.petShop:
        return context.appLocalization.petShop;
      case ItemType.snacks:
        return context.appLocalization.snacks;
      case ItemType.vegetablesAndFruits:
        return context.appLocalization.vegetablesAndFruits;
      default:
        return '';
    }
  }
}
