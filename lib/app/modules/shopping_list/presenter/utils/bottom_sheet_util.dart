import 'package:easy_market/app/shared/themes/themes.dart';
import 'package:flutter/material.dart';

import '../widgets/bottom_sheet_form.dart';

abstract class BottomSheetUtil {
  static Future<void> openBottomSheet({
    required BuildContext context,
    required String title,
    required Widget child,
  }) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      backgroundColor: Colors.transparent,
      builder: (dialogContext) => Container(
        height: context.height * 0.7,
        decoration: BoxDecoration(
          color: context.colorsScheme.background,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        child: ScaffoldMessenger(
          child: Builder(builder: (context) {
            return Scaffold(
              backgroundColor: Colors.transparent,
              body: BottomSheetForm(
                title: title,
                child: child,
              ),
            );
          }),
        ),
      ),
    );
  }
}
