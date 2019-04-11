import 'dart:convert';

import 'package:backlog_app/constants.dart';
import 'package:backlog_app/model/note.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

class BacklogListBloc {
  final _notesSubject = BehaviorSubject<List<Note>>();
  final _getNotesSubject = PublishSubject<void>();

  BacklogListBloc() {
    _getNotesSubject.listen((_) => _getNotes());
  }

  Sink<void> get requestNotesSink => _getNotesSubject.sink;

  Observable<List<Note>> get notes => _notesSubject.stream;

  Future<void> _getNotes() async {
    http.Response response = await http.get('$https$apiDomain/getItems');
    print(response.body);
    if (response.statusCode == 200) {
      List body = json.decode(response.body);
      List<Note> notes = body.map((json) => Note.fromJson(json)).toList();
      _notesSubject.add(notes);
    } else {
      print(response.statusCode);
    }
  }

  void dispose() {
    _notesSubject.close();
    _getNotesSubject.close();
  }
}
