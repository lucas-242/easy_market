import 'dart:async';

import 'package:easy_market/app/shared/services/stream_subscriptions_cancel.dart';
import 'package:flutter_modular/flutter_modular.dart';

extension EnumExtension on Enum {
  String toShortString() {
    // ignore: unnecessary_this
    return this.toString().split('.').last;
  }
}

extension EnumNullableExtension on Enum? {
  String? toShortString() {
    if (this == null) {
      return null;
    }

    // ignore: unnecessary_this
    return this.toString().split('.').last;
  }
}

extension StreamSubscriptionsCancelExtension on StreamSubscription {
  void cancelOnFinishApp() {
    Modular.get<StreamSubscriptionsCancel>().addSubscription(this);
  }
}
