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
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
      builder: (dialogContext) => BottomSheetForm(
        title: title,
        child: child,
      ),
    );
  }
}
