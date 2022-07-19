import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
part 'stream_subscriptions_cancel.g.dart';

@Injectable()
class StreamSubscriptionsCancel {
  final List<StreamSubscription> _subscriptions = [];

  Future<void> cancelSubscriptions() async {
    for (var subscription in _subscriptions) {
      await subscription.cancel();
    }
  }

  void addSubscription(StreamSubscription subscription) {
    _subscriptions.add(subscription);
  }
}
