import 'package:blueprint/utils/mixins/library_mixins.dart';
import 'package:blueprint/widgets/buttons/suffix_icon_button.dart';
import 'package:blueprint/widgets/texts/translated_text.dart';
import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  const SearchField({
    super.key,
    required this.label,
    required this.prefixIcon,
    required this.onChanged,
  });

  final String label;
  final Widget prefixIcon;
  final ValueChanged<String> onChanged;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField>
    with TextEditingControllersMixin {
  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      autocorrect: false,
      controller: searchController,
      decoration: InputDecoration(
        label: TranslatedText(widget.label),
        prefixIcon: widget.prefixIcon,
        suffixIcon: searchController.text.trim().isEmpty
            ? null
            : SuffixIconButton(
                onTap: () {
                  searchController.clear();
                  widget.onChanged.call('');
                },
                child: const Icon(Icons.clear),
              ),
      ),
      onChanged: (search) => widget.onChanged(search.trim()),
    );
  }
}
