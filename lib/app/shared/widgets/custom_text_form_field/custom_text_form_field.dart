import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_market/app/shared/themes/themes.dart';

class CustomTextFormField extends StatelessWidget {
  final GlobalKey<FormFieldState>? textFormKey;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String labelText;
  final String hintText;
  final String? initialValue;
  final bool readOnly;
  final bool obscureText;
  final Widget? suffix;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function(String value)? onChanged;
  final void Function()? onTap;

  const CustomTextFormField({
    Key? key,
    this.textFormKey,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    required this.labelText,
    this.hintText = '',
    this.initialValue,
    this.validator,
    this.controller,
    this.onChanged,
    this.inputFormatters,
    this.onTap,
    this.readOnly = false,
    this.obscureText = false,
    this.suffix,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: textFormKey,
      controller: controller,
      initialValue: initialValue,
      validator: validator,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      readOnly: readOnly,
      onChanged: onChanged,
      onTap: onTap,
      style: context.bodyLarge,
      inputFormatters: inputFormatters,
      obscureText: obscureText,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        hintStyle: context.bodyLarge!,
        suffixIcon: suffix,
      ),
    );
  }
}
