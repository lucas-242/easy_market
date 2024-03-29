import '../../../../core/l10n/generated/l10n.dart';

import '../bloc/shopping_list_bloc/shopping_list_bloc.dart';
import '../../../../shared/widgets/custom_elevated_button/custom_elevated_button.dart';
import '../../../../shared/widgets/custom_text_form_field/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShoppingListForm extends StatefulWidget {
  final void Function() onSubmit;

  const ShoppingListForm({Key? key, required this.onSubmit}) : super(key: key);

  @override
  State<ShoppingListForm> createState() => _ShoppingListFormState();
}

class _ShoppingListFormState extends State<ShoppingListForm> {
  final _formKey = GlobalKey<FormState>();
  final _namelKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _NameField(fieldKey: _namelKey),
          const SizedBox(height: 30),
          _Button(onSubmit: widget.onSubmit)
        ],
      ),
    );
  }
}

class _NameField extends StatelessWidget {
  final GlobalKey<FormFieldState> fieldKey;
  const _NameField({Key? key, required this.fieldKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<ShoppingListBloc>();
    final label = AppLocalizations.of(context).name;

    return CustomTextFormField(
      textFormKey: fieldKey,
      labelText: label,
      initialValue: bloc.state.currentShoppingList.name,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      onChanged: (value) => bloc.add(ChangeNameEvent(value)),
      validator: (value) =>
          bloc.validateTextField(fieldValue: value, fieldName: label),
    );
  }
}

class _Button extends StatelessWidget {
  final void Function() onSubmit;

  const _Button({Key? key, required this.onSubmit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<ShoppingListBloc>();

    return CustomElevatedButton(
      onTap: onSubmit,
      text: bloc.state.currentShoppingList.id.isEmpty
          ? AppLocalizations.of(context).create
          : AppLocalizations.of(context).update,
    );
  }
}
