import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final notes = List<String>.generate(20, (index) => 'Note ${++index}');

    return Center(
      child: Scrollbar(
        child: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(notes[index]),
              onTap: () {
                context.go('/notes/detail');
              },
            );
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
          itemCount: notes.length,
        ),
      ),
    );
  }
}
