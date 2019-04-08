import 'package:backlog_app/note.dart';
import 'package:flutter/material.dart';

///Widget displaying one card in with text and likes
class NoteCard extends StatelessWidget {
  final Note note;
  final VoidCallback onLikeTap;

  const NoteCard({Key key, @required this.note, @required this.onLikeTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              width: double.infinity,
              color: note.color,
              padding: const EdgeInsets.all(16),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      note.text,
                      style: TextStyle(fontSize: 18),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '- ${note.author}',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 8),
            child: _NoteCardLikeRow(note: note, onLikeTap: onLikeTap),
          ),
        ],
      ),
    );
  }
}

///A row displaying number of likes and having like button
class _NoteCardLikeRow extends StatelessWidget {
  final Note note;
  final VoidCallback onLikeTap;

  const _NoteCardLikeRow({
    Key key,
    @required this.note,
    @required this.onLikeTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          '+${note.likes}',
          style: TextStyle(fontSize: 20),
        ),
        FlatButton(
          highlightColor: note.color.withOpacity(0.5),
          onPressed: onLikeTap,
          child: Row(
            children: <Widget>[
              Text(
                'Like it!',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(width: 8),
              Icon(Icons.thumb_up),
            ],
          ),
        )
      ],
    );
  }
}
