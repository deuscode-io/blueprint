import 'package:blueprint/core/DI/injector.dart';
import 'package:blueprint/core/i18n/locale_keys.g.dart';
import 'package:blueprint/core/i18n/translate.dart';
import 'package:blueprint/features/countries/models/country.dart';
import 'package:blueprint/widgets/buttons/suffix_icon_button.dart';
import 'package:blueprint/widgets/texts/translated_text.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PhoneNumberField extends StatefulWidget {
  static final Translate _translate = Injector.get();

  const PhoneNumberField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    this.onSubmitted,
    required this.errorText,
    required this.initialPhoneNumber,
    required this.country,
  });

  final Country country;
  final String initialPhoneNumber;
  final String? errorText;
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final ValueChanged<String>? onSubmitted;

  @override
  State<PhoneNumberField> createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<PhoneNumberField> {
  late MaskTextInputFormatter maskFormatter;

  @override
  void initState() {
    super.initState();
    maskFormatter = MaskTextInputFormatter(
      initialText: widget.initialPhoneNumber,
      mask: widget.country.mask,
      filter: {'#': RegExp(r'[0-9 \-()]')},
    );
    widget.controller.text = maskFormatter.getMaskedText();
  }

  @override
  void didUpdateWidget(covariant PhoneNumberField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.country.mask != widget.country.mask) _applyNewPhoneMask();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      inputFormatters: [
        maskFormatter,
      ],
      onTapOutside: (_) => widget.focusNode.unfocus(),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        errorText: widget.errorText == null ? null : PhoneNumberField._translate(widget.errorText!),
        prefixIcon: const Icon(Icons.phone),
        suffixIcon: widget.controller.text.trim().isEmpty
            ? null
            : SuffixIconButton(
                onTap: () {
                  widget.controller.clear();
                  if (!widget.focusNode.hasFocus) {
                    widget.focusNode.requestFocus();
                  }
                  widget.onChanged.call('');
                },
                child: const Icon(Icons.clear),
              ),
        label: const TranslatedText(LocaleKeys.text_field_labels_phone_number),
        counterText: '',
      ),
      onChanged: (_) => _onChangePhoneNumber(),
      onSubmitted: (text) => widget.onSubmitted?.call(text.trim()),
    );
  }

  void _applyNewPhoneMask() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        widget.controller.value = maskFormatter.updateMask(
          mask: widget.country.mask,
        );
        _onChangePhoneNumber();
      }
    });
  }

  void _onChangePhoneNumber() {
    widget.onChanged.call(maskFormatter.getUnmaskedText());
  }
}
