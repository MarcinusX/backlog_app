import 'package:backlog_app/model/note.dart';
import 'package:backlog_app/widget/new_note_page.dart';
import 'package:backlog_app/widget/note_card.dart';
import 'package:flutter/material.dart';

class BacklogListPage extends StatelessWidget {
  final List<Note> notes = [
    Note(1, 'jakiś tekst', 'autor1', Colors.red, 3),
    Note(1, 'jakiś ksjfgnkjdfsnagkjansdkjfgb sdkfbnsdajkf sdfk aksjf ',
        'autor1', Colors.red, 3),
    Note(1, 'jakiś wincyj  :)', 'autor2', Colors.blue, 3),
    Note(1, 'jakiś tekst', 'autor2', Colors.yellow, 2),
    Note(1, 'jakiś tekst', 'autor3', Colors.pink, 3),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Backlog App'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: notes.map((Note note) {
          return NoteCard(note: note);
        }).toList(),
      ),
      floatingActionButton: _MyFloatingActionButton(),
    );
  }
}

class _MyFloatingActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => NewNotePage(),
        ));
      },
    );
  }
}
