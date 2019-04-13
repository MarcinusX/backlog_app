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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    note.text,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '- ${note.author}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
                  )
                ],
              ),
            ),
          ),
          _BottomLikeRow(note: note),
        ],
      ),
    );
  }
}

class _BottomLikeRow extends StatelessWidget {
  final Note note;

  const _BottomLikeRow({Key key, @required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      child: Row(
        children: <Widget>[
          SizedBox(width: 8),
          Text(
            '+ ${note.likes}',
            style: TextStyle(fontSize: 20),
          ),
          Spacer(),
          FlatButton(
            highlightColor: note.color.withOpacity(0.5),
            child: Row(
              children: <Widget>[
                Icon(Icons.thumb_up),
                SizedBox(width: 8),
                Text('LIKE!'),
              ],
            ),
            onPressed: (){},
          )
        ],
      ),
    );
  }
}
