import 'package:flutter/material.dart';

import '/app/shared/themes/themes.dart';
import 'item_form.dart';

class BottomSheetItemForm extends StatelessWidget {
  final String title;
  final void Function() onSubmit;
  const BottomSheetItemForm(
      {Key? key, required this.onSubmit, this.title = 'Add new item'})
      : super(key: key);

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
              ItemForm(onSubmit: onSubmit),
            ],
          ),
        ),
      ),
    );
  }
}
