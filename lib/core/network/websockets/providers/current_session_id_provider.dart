import 'package:injectable/injectable.dart';

@singleton
class CurrentSessionIdProvider {
  String? _currentSessionId;

  void setSessionId(String? value) => _currentSessionId = value;

  bool isOldSession(String sessionId) => _currentSessionId != sessionId;
}
