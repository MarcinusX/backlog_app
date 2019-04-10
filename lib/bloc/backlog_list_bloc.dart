import 'dart:convert';

import 'package:backlog_app/constants.dart';
import 'package:backlog_app/note.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

class BacklogListBloc {
  final _notesSubject = BehaviorSubject<List<Note>>();
  final _likeSubject = PublishSubject<int>();
  final _requestSubject = PublishSubject<void>();

  BacklogListBloc() {
    _requestSubject.listen((_) => requestNotes());
    _likeSubject.listen(_likeANote);
    _requestSubject.add(null);
  }

  ///Returns stream of notes to be displayed
  Observable<List<Note>> get notes => _notesSubject.stream;

  ///Add anything to request notes
  Sink<void> get requestNotesSink => _requestSubject.sink;

  ///Pass the note's id to like it
  Sink<int> get likeNote => _likeSubject.sink;

  Future<void> requestNotes() async {
    http.Response response = await http.get('$https$domain/getItems');
    List body = json.decode(response.body);
    List<Note> notes = body.map((map) => Note.fromJson(map)).toList();
    _notesSubject.add(notes);
  }

  Future<void> _likeANote(int id) async {
    Map<String, String> queryParams = {
      'id': '$id'
    };
    Uri uri = Uri.https(domain, '/like', queryParams);
    http.Response response = await http.put(uri);
    _requestSubject.add(null);
  }

  void dispose() {
    _notesSubject.close();
    _likeSubject.close();
    _requestSubject.close();
  }
}
