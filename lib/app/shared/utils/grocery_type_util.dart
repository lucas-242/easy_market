import 'package:market_lists/app/modules/grocery/grocery.dart';
import 'package:market_lists/app/shared/extensions/extensions.dart';

abstract class GroceryTypeUtil {
  static GroceryType? fromText(String string) {
    string = string.toLowerCase();

    if (string == GroceryType.dairy.toShortString()) {
      return GroceryType.dairy;
    } else {
      return null;
    }
  }

  static String toText(GroceryType groceryType) {
    return groceryType.toShortString();
  }
}
