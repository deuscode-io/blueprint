import 'package:talker_flutter/talker_flutter.dart';

class Logger {
  const Logger({required this.talker});

  final Talker talker;

  void log(String message) {
    talker.log(message);
  }

  void info(String message) {
    talker.info(message);
  }

  void warning(String message) {
    talker.warning(message);
  }

  void error(
    String message, {
    required Object exception,
    StackTrace? stackTrace,
  }) {
    talker.log(
      message,
      exception: exception,
      stackTrace: stackTrace ?? StackTrace.current,
      logLevel: LogLevel.error,
    );
  }
}
