import 'package:flutter/material.dart';

class ThemeSettings {
  ThemeSettings({
    required this.sourceColor,
    required this.themeMode,
  });

  final Color sourceColor;
  final ThemeMode themeMode;
}

ThemeSettings get defaultThemeSettings => ThemeSettings(
    sourceColor: const Color.fromARGB(255, 249, 176, 7),
    themeMode: ThemeMode.system);
