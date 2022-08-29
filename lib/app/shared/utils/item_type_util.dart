import '../../core/l10n/generated/l10n.dart';

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

  static String stringfy(ItemType? itemType) {
    switch (itemType) {
      case null:
        return '';
      case ItemType.breadAndBreadSpreads:
        return AppLocalizations.current.breadAndBreadSpreads;
      case ItemType.careProducts:
        return AppLocalizations.current.careProducts;
      case ItemType.cleaningProducts:
        return AppLocalizations.current.cleaningProducts;
      case ItemType.dairy:
        return AppLocalizations.current.dairy;
      case ItemType.dryGoods:
        return AppLocalizations.current.dryGoods;
      case ItemType.frozen:
        return AppLocalizations.current.frozen;
      case ItemType.meatAndFish:
        return AppLocalizations.current.meatAndFish;
      case ItemType.petShop:
        return AppLocalizations.current.petShop;
      case ItemType.snacks:
        return AppLocalizations.current.snacks;
      case ItemType.vegetablesAndFruits:
        return AppLocalizations.current.vegetablesAndFruits;
      default:
        return '';
    }
  }
}
