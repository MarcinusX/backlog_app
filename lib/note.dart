import 'dart:ui';

class Note {
  final int id;
  final String text;
  final String author;
  final Color color;
  final int likes;

  Note(this.id, this.text, this.author, this.likes, this.color);

  Note.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        text = json['text'],
        author = json['author'],
        color = Color(json['color']),
        likes = json['likes'];
}
