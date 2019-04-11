import 'package:backlog_app/model/note.dart';
import 'package:backlog_app/widget/new_note_page.dart';
import 'package:backlog_app/widget/note_card.dart';
import 'package:flutter/material.dart';

class BacklogListPage extends StatelessWidget {
  final List<Note> notes = [
    Note('Autor1', 'Super pomysł na ekstra apkę', Colors.yellow, 3),
    Note('Autor1', 'A to pomysł na mega feature', Colors.red, 7),
    Note(
        'Autor2',
        'Trzeci pomysł jest bardzo bardzo bardzo bardzo bardzo bardzo bardzo bardzo bardzo bardzo bardzo bardzo bardzo bardzo długi',
        Colors.green,
        3),
    Note('Autor2', 'Pouczmy się Fluttera', Colors.blue, 3),
    Note('Autor3', 'Jeśli to widzisz to znaczy, że checkoutowałeś z gita',
        Colors.red, 0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Backlog App'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: notes.map((Note note) => NoteCard(note: note)).toList(),
      ),
      floatingActionButton: _NewNoteFloatingActionButton(),
    );
  }
}

class _NewNoteFloatingActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () => _goToNewNotePage(context),
    );
  }

  void _goToNewNotePage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => NewNotePage(),
    ));
  }
}
