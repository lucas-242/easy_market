import 'package:flutter/material.dart';

import '/app/shared/themes/themes.dart';
import 'item_form.dart';

class BottomSheetItemForm extends StatelessWidget {
  final void Function() onSubmit;
  const BottomSheetItemForm({Key? key, required this.onSubmit})
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
              Text('Add new item', style: context.titleLarge),
              const SizedBox(height: 25),
              ItemForm(onSubmit: onSubmit),
            ],
          ),
        ),
      ),
    );
  }
}
