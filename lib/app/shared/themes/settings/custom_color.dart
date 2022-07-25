import 'package:easy_market/app/shared/themes/settings/theme_provider.dart';
import 'package:flutter/material.dart';

class CustomColor {
  const CustomColor({
    required this.name,
    required this.color,
    this.blend = true,
  });

  final String name;
  final Color color;
  final bool blend;

  Color value(ThemeProvider theme) {
    return theme.customizeColor(this);
  }
}
