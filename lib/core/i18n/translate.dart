import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';

@singleton
class Translate {
  const Translate();

  String call(
    String code, {
    List<String> arguments = const [],
    Map<String, String>? namedArguments = const {},
  }) {
    return code.tr(
      args: arguments,
      namedArgs: namedArguments,
    );
  }
}
