import 'package:easy_market/app/core/l10n/generated/l10n.dart';
import 'package:flutter/material.dart';

abstract class TestHelper {
  static Future<void> loadAppLocalizations() async {
    await AppLocalizations.load(const Locale.fromSubtags(languageCode: 'en'));
  }
}
