import 'package:backlog_app/bloc/backlog_list_bloc.dart';
import 'package:backlog_app/bloc/bloc_provider.dart';
import 'package:backlog_app/bloc/new_note_bloc.dart';
import 'package:backlog_app/note.dart';
import 'package:backlog_app/ui/add_note_page.dart';
import 'package:backlog_app/ui/note_card.dart';
import 'package:flutter/material.dart';

///Page displaying all notes in form of cards
class BacklogPage extends StatelessWidget {
  const BacklogPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BacklogListBloc bloc = BlocProvider.of(context).backlogListBloc;
    return Scaffold(
      appBar: AppBar(
        title: Text('Backlog'),
      ),
      body: StreamBuilder<List<Note>>(
        stream: bloc.notes,
        builder: (context, AsyncSnapshot<List<Note>> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return RefreshIndicator(
            onRefresh: () => bloc.requestNotes(),
            child: GridView.count(
              crossAxisCount: 2,
              children: snapshot.data
                  .map((note) => NoteCard(
                        note: note,
                        onLikeTap: () => bloc.likeNote.add(note.id),
                      ))
                  .toList(),
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
              childAspectRatio: 1,
            ),
          );
        },
      ),
      floatingActionButton: _BacklogFab(
        listBloc: bloc,
      ),
    );
  }
}

///Floating action button which opens new item page
class _BacklogFab extends StatelessWidget {
  const _BacklogFab({Key key, @required this.listBloc}) : super(key: key);
  final BacklogListBloc listBloc;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => onPressed(context),
      child: Icon(Icons.add),
    );
  }

  void onPressed(BuildContext context) async {
    NewNoteBloc bloc = NewNoteBloc();
    bool result = await Navigator.of(context).push<bool>(MaterialPageRoute(
      builder: (context) => AddNotePage(bloc: bloc),
      fullscreenDialog: true,
    ));
    if (result == true) {
      listBloc.requestNotesSink.add(null);
    }
    bloc.dispose();
  }
}
