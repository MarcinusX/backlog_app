import 'dart:ui';

class Note {
  final String author;
  final String text;
  final Color color;
  final int likes;
  final int id;

  Note(this.author, this.text, this.color, this.likes, [this.id]);

  Note.fromJson(Map<String, dynamic> map)
      : author = map['author'],
        text = map['text'],
        color = Color(map['color']),
        likes = map['likes'],
        id = map['id'];
}
