import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../l10n/generated/app_localizations.dart';
import '../services/stream_subscriptions_cancel.dart';
import 'package:flutter_modular/flutter_modular.dart';

extension StringExtensions on String {
  String capitalize() {
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }
}

extension EnumExtension on Enum {
  String toShortString() {
    return toString().split('.').last;
  }
}

extension EnumNullableExtension on Enum? {
  String? toShortString() {
    if (this == null) {
      return null;
    }

    return toString().split('.').last;
  }
}

extension StreamSubscriptionsCancelExtension on StreamSubscription {
  void cancelOnFinishApp() {
    Modular.get<StreamSubscriptionsCancel>().addSubscription(this);
  }
}

extension BuildContextExtension on BuildContext {
  AppLocalizations get appLocalization {
    return AppLocalizations.of(this);
  }
}
