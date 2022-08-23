import 'dart:async';

import '../services/stream_subscriptions_cancel.dart';
import 'package:flutter_modular/flutter_modular.dart';

extension StringExtensions on String {
  String capitalize() {
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }

  String getInitials({int numberLetters = 2}) {
    List<String> words = split(RegExp(r'^[\ _\-]'));

    if (numberLetters < words.length) {
      numberLetters = words.length;
    }

    final result = _getLettersFromWords(words, numberLetters).toUpperCase();
    return result;
  }

  String _getLettersFromWords(List<String> words, int numberLetters) {
    String result = "";
    var lastWordLastLetterIndex = 0;

    for (var i = 0; i < numberLetters; i++) {
      if (words.length <= i) {
        result += words.last[lastWordLastLetterIndex + 1];
        lastWordLastLetterIndex++;
      } else {
        result += words[i][0];
      }
    }

    return result;
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
