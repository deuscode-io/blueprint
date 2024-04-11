import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@singleton
class OnWebSocketDisconnectionAction {
  const OnWebSocketDisconnectionAction();

  Future<void> call(dynamic data) async {
    debugPrint('OnWebSocketDisconnectionListener data: $data');
  }
}
