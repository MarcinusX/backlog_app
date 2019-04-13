import 'package:backlog_app/bloc/backlog_list_bloc.dart';
import 'package:backlog_app/bloc/bloc_provider.dart';
import 'package:backlog_app/bloc/new_note_bloc.dart';
import 'package:backlog_app/model/note.dart';
import 'package:backlog_app/widget/new_note_page.dart';
import 'package:backlog_app/widget/note_card.dart';
import 'package:flutter/material.dart';

class BacklogListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BacklogListBloc bloc = BlocProvider.of(context).backlogListBloc;
    return Scaffold(
      appBar: AppBar(
        title: Text('Backlog App'),
      ),
      body: StreamBuilder<List<Note>>(
          stream: bloc.notes,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return GridView.count(
              crossAxisCount: 2,
              children: snapshot.data.map((Note note) {
                return NoteCard(note: note);
              }).toList(),
            );
          }),
      floatingActionButton: _MyFloatingActionButton(),
    );
  }
}

class _MyFloatingActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () => _onPressed(context),
    );
  }

  void _onPressed(BuildContext context) async {
    NewNoteBloc newNoteBloc = NewNoteBloc();
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => NewNotePage(bloc: newNoteBloc),
    ));
    newNoteBloc.dispose();
    BlocProvider.of(context).backlogListBloc.requestNotesSink.add(null);
  }
}
