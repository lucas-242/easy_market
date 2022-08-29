import 'package:dropdown_search/dropdown_search.dart';
import '../../../../shared/utils/item_type_util.dart';
import '../../../../core/l10n/generated/l10n.dart';
import '../bloc/items_bloc/items_bloc.dart';
import '../../shopping_list.dart';
import '../../../../shared/extensions/extensions.dart';
import '../../../../shared/themes/themes.dart';
import '../../../../shared/widgets/custom_elevated_button/custom_elevated_button.dart';
import '../../../../shared/widgets/custom_text_form_field/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemForm extends StatefulWidget {
  final void Function() onSubmit;

  const ItemForm({Key? key, required this.onSubmit}) : super(key: key);

  @override
  State<ItemForm> createState() => _ItemFormState();
}

class _ItemFormState extends State<ItemForm> {
  final _formKey = GlobalKey<FormState>();
  final _namelKey = GlobalKey<FormFieldState>();
  final _quantityKey = GlobalKey<FormFieldState>();
  final _priceKey = GlobalKey<FormFieldState>();
  final _typeKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _NameField(fieldKey: _namelKey),
          const SizedBox(height: 20),
          _TypeField(fieldKey: _typeKey),
          const SizedBox(height: 20),
          _QuantityField(fieldKey: _quantityKey),
          const SizedBox(height: 20),
          _PriceField(fieldKey: _priceKey),
          const SizedBox(height: 30),
          _Button(onSubmit: widget.onSubmit),
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
    final bloc = context.watch<ItemsBloc>();
    final label = AppLocalizations.of(context).name;

    return CustomTextFormField(
      textFormKey: fieldKey,
      labelText: label,
      initialValue: bloc.state.currentItem.name,
      keyboardType: TextInputType.text,
      onChanged: (value) => bloc.add(ChangeNameEvent(value)),
      validator: (value) =>
          bloc.validateTextField(fieldValue: value, fieldName: label),
    );
  }
}

class _TypeField extends StatelessWidget {
  final GlobalKey<FormFieldState> fieldKey;
  const _TypeField({Key? key, required this.fieldKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<ItemsBloc>();
    final label = AppLocalizations.of(context).type;

    return DropdownSearch<ItemType>(
      items: ItemType.values,
      itemAsString: (ItemType? itemType) => ItemTypeUtil.stringfy(itemType),
      selectedItem: bloc.state.currentItem.type,
      compareFn: (item1, item2) =>
          item1.toShortString() == item2.toShortString(),
      onChanged: (value) => bloc.add(ChangeTypeEvent(value)),
      validator: (value) => bloc.validateItemTypeField(fieldValue: value),
      autoValidateMode: AutovalidateMode.onUserInteraction,
      popupProps: const PopupProps.menu(
        showSelectedItems: true,
        fit: FlexFit.loose,
      ),
      dropdownDecoratorProps: const DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          contentPadding: EdgeInsets.symmetric(horizontal: 18),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
      ),
      dropdownBuilder: (context, selectedItem) => Text(
        selectedItem == null ? label : ItemTypeUtil.stringfy(selectedItem),
        style: context.bodyLarge
            ?.copyWith(color: context.colorsScheme.onSurfaceVariant),
      ),
    );
  }
}

class _QuantityField extends StatelessWidget {
  final GlobalKey<FormFieldState> fieldKey;
  const _QuantityField({Key? key, required this.fieldKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<ItemsBloc>();
    final label = AppLocalizations.of(context).quantity;

    return CustomTextFormField(
      textFormKey: fieldKey,
      labelText: label,
      initialValue: bloc.state.currentItem.quantity > 0
          ? bloc.state.currentItem.quantity.toString()
          : '',
      keyboardType: TextInputType.number,
      onChanged: (value) => bloc.add(ChangeQuantityEvent(value)),
      validator: (value) => bloc.validateNumberField(
        fieldValue: value,
        fieldName: label,
      ),
    );
  }
}

class _PriceField extends StatelessWidget {
  final GlobalKey<FormFieldState> fieldKey;
  const _PriceField({Key? key, required this.fieldKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<ItemsBloc>();
    final label = AppLocalizations.of(context).price;

    return CustomTextFormField(
      textFormKey: fieldKey,
      labelText: label,
      initialValue: bloc.state.currentItem.price?.toString(),
      keyboardType: TextInputType.number,
      onChanged: (value) => bloc.add(ChangePriceEvent(value)),
      validator: (value) => bloc.validatePriceField(
        fieldValue: value,
        fieldName: label,
      ),
    );
  }
}

class _Button extends StatelessWidget {
  final void Function() onSubmit;

  const _Button({Key? key, required this.onSubmit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<ItemsBloc>();

    return CustomElevatedButton(
      onTap: onSubmit,
      text: bloc.state.currentItem.id.isEmpty
          ? AppLocalizations.of(context).add
          : AppLocalizations.of(context).update,
    );
  }
}
