import 'package:flutter/material.dart';

import '/app/shared/themes/themes.dart';

class BottomSheetForm extends StatelessWidget {
  final String title;
  final Widget child;
  const BottomSheetForm({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title, style: context.titleLarge),
              const SizedBox(height: 25),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
