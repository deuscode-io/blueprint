import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@singleton
class OnWebSocketDataAction {
  const OnWebSocketDataAction();

  Future<void> call(dynamic data) async {
    debugPrint('OnWebSocketDataListener data: $data');
  }
}
