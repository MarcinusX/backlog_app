import 'dart:convert';
import 'dart:io';

import 'package:backlog_app/constants.dart';
import 'package:backlog_app/model/note.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

class BacklogListBloc {
  final _notesSubject = BehaviorSubject<List<Note>>();
  final _requestSubject = PublishSubject<void>();

  BacklogListBloc() {
    _requestSubject.listen((_) => _requestNotes());
  }

  Observable<List<Note>> get notes => _notesSubject.stream;

  Sink<void> get requestNotesSink => _requestSubject.sink;

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

  void dispose() {
    _notesSubject.close();
    _requestSubject.close();
  }
}
