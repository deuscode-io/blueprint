import 'dart:async';

import 'package:injectable/injectable.dart';

@singleton
class ConnectionSubscriptionProvider {
  StreamSubscription? _connectionSubscription;

  StreamSubscription? getSubscription() => _connectionSubscription;

  Future<void> cancelSubscription() async {
    _connectionSubscription?.cancel();
  }

  void setSubscription(StreamSubscription? value) {
    _connectionSubscription = value;
  }
}
