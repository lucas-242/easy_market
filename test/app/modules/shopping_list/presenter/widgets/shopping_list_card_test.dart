import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_market/app/modules/shopping_list/presenter/widgets/shopping_list_card.dart';

import '../../../../test_widget_wrapper.dart';
import '../../mock_shopping_list_test.dart';

void main() {
  testWidgets('Should return id onTap Card', (tester) async {
    String result = '';
    await tester.pumpWidget(
      TestWidgetWrapper(
        child: ShoppingListCard(
          shoppingList: shoppingList,
          onTap: (id) {
            result = id;
          },
          onTapDelete: (shoppingList) {},
          onTapUpdate: (shoppingList) {},
        ),
      ),
    );
    await tester.tap(find.byType(InkWell).first);
    await tester.pumpAndSettle();
    expect(result, shoppingList.id);
  });
}
