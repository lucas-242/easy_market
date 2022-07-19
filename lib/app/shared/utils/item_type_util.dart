import 'package:easy_market/app/shared/extensions/extensions.dart';

import '../../modules/shopping_list/shopping_list.dart';

abstract class ItemTypeUtil {
  static ItemType? fromText(String string) {
    string = string.toLowerCase();

    if (string == ItemType.dairy.toShortString()) {
      return ItemType.dairy;
    } else {
      return null;
    }
  }

  static String toText(ItemType itemType) {
    return itemType.toShortString();
  }
}
