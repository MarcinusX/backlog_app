import 'dart:convert';
import 'dart:io';

import 'package:backlog_app/constants.dart';
import 'package:backlog_app/model/note.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

class BacklogListBloc {
  final _notesSubject = BehaviorSubject<List<Note>>();
  final _requestSubject = PublishSubject<void>();
  final _likeSubject = PublishSubject<Note>();

  BacklogListBloc() {
    _requestSubject.listen((_) => _requestNotes());
    _likeSubject.listen(_likeNote);
  }

  Observable<List<Note>> get notes => _notesSubject.stream;

  Sink<void> get requestNotesSink => _requestSubject.sink;

  Sink<Note> get likeSink => _likeSubject.sink;

  void _requestNotes() async {
    http.Response response = await http.get('$apiUrl/getItems');
    print(response.body);
    if (response.statusCode == HttpStatus.ok) {
      List jsonList = json.decode(response.body);
      List<Note> noteList =
          jsonList.map((json) => Note.fromJson(json)).toList();
      _notesSubject.add(noteList);
    } else {
      print(response.statusCode);
    }
  }

  void _likeNote(Note note) async {
    await http.put('$apiUrl/like?id=${note.id}');
    _requestSubject.add(null);
  }

  void dispose() {
    _likeSubject.close();
    _notesSubject.close();
    _requestSubject.close();
  }
}
