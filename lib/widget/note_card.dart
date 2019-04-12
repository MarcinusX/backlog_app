import 'package:backlog_app/bloc/backlog_list_bloc.dart';
import 'package:backlog_app/bloc/bloc_provider.dart';
import 'package:backlog_app/model/note.dart';
import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
  final Note note;

  const NoteCard({Key key, @required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: note.color,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: <Widget>[
                  Text(
                    note.text,
                    style: TextStyle(fontSize: 18),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Spacer(),
                  Text(
                    '- ${note.author}',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  )
                ],
              ),
            ),
          ),
          _NoteCardLikeRow(note: note),
        ],
      ),
    );
  }
}

class _NoteCardLikeRow extends StatelessWidget {
  final Note note;

  const _NoteCardLikeRow({Key key, @required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 4, left: 16, bottom: 4),
      color: Colors.white,
      width: double.infinity,
      child: Row(
        children: <Widget>[
          Text(
            '+ ${note.likes}',
            style: TextStyle(fontSize: 20),
          ),
          Spacer(),
          FlatButton(
            highlightColor: note.color.withOpacity(0.5),
            child: Row(
              children: <Widget>[
                Text('LIKE!'),
                SizedBox(width: 8),
                Icon(Icons.thumb_up),
              ],
            ),
            onPressed: () {
              BacklogListBloc bloc = BlocProvider.of(context).backlogListBloc;
              bloc.likeNoteSink.add(note);
            },
          )
        ],
      ),
    );
  }
}
