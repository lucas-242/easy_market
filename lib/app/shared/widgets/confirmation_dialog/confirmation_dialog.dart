import '../../themes/themes.dart';
import '../custom_elevated_button/custom_elevated_button.dart';
import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onConfirm;
  final String title;
  final String message;
  final String cancelButton;
  final String confirmButton;

  const ConfirmationDialog({
    Key? key,
    required this.onConfirm,
    required this.onCancel,
    this.title = 'Confirm action',
    this.message = 'Would you like to confirm this action?',
    this.cancelButton = 'Cancel',
    this.confirmButton = 'Confirm',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var colors = Theme.of(context).colorScheme;
    return AlertDialog(
      key: key ?? const Key('AlertDialog'),
      title: Text(title),
      content: Text(message),
      actions: [
        CustomElevatedButton(
          onTap: onCancel,
          text: cancelButton,
          width: context.width * 0.3,
          backgroundColor: colors.background,
          foregroundColor: colors.onSurface,
        ),
        CustomElevatedButton(
          onTap: onConfirm,
          text: confirmButton,
          width: context.width * 0.3,
          backgroundColor: colors.errorContainer,
          foregroundColor: colors.onSurface,
        ),
      ],
    );
  }
}
