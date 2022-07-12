import 'package:flutter/material.dart';
import 'package:market_lists/app/shared/themes/theme_utils.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Size? size;

  const CustomElevatedButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.backgroundColor,
    this.foregroundColor,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: key,
      onPressed: onTap,
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all<Size>(
            size ?? Size(context.width * 0.4, context.height * 0.067)),
        backgroundColor: backgroundColor != null
            ? MaterialStateProperty.all<Color>(backgroundColor!)
            : null,
        foregroundColor: foregroundColor != null
            ? MaterialStateProperty.all<Color>(foregroundColor!)
            : null,
      ),
      child: Text(text),
    );
  }
}
