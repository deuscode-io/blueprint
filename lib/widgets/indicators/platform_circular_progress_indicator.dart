import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PlatformCircularProgressIndicator extends StatelessWidget {
  const PlatformCircularProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return switch (defaultTargetPlatform) {
      TargetPlatform.iOS => const CupertinoActivityIndicator(),
      _ => const CircularProgressIndicator()
    };
  }
}
