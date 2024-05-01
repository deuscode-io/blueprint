import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class ShowDraggableBottomSheetAction {
  const ShowDraggableBottomSheetAction();

  Future<dynamic> call({
    required Function(ScrollController) onBuiltScrollController,
    required BuildContext context,
  }) async {
    return showModalBottomSheet(
      context: context,
      enableDrag: true,
      isDismissible: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.9,
        minChildSize: 0.89,
        maxChildSize: 0.9,
        builder: (context, scrollController) {
          return onBuiltScrollController(scrollController);
        },
      ),
    );
  }
}
