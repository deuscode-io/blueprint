import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart' hide Locale;

class TranslatedText extends StatefulWidget {
  const TranslatedText(
    this.text, {
    super.key,
    this.textAlign,
    this.style = const TextStyle(),
    this.arguments = const [],
    this.namedArguments = const {},
    this.overflow = TextOverflow.visible,
  });

  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextOverflow overflow;
  final List<String> arguments;
  final Map<String, String>? namedArguments;

  @override
  State<TranslatedText> createState() => _TranslatedTextState();
}

class _TranslatedTextState extends State<TranslatedText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text.tr(
        args: widget.arguments,
        namedArgs: widget.namedArguments,
      ),
      overflow: widget.overflow,
      textAlign: widget.textAlign,
      style: widget.style,
    );
  }
}
