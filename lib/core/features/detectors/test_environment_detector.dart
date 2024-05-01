import 'dart:io';

import 'package:injectable/injectable.dart';

@lazySingleton
class TestEnvironmentDetector {
  const TestEnvironmentDetector();

  bool call() => Platform.environment.containsKey('FLUTTER_TEST');
}
