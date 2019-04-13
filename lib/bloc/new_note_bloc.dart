import 'dart:convert';

import 'package:backlog_app/constants.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

class NewNoteBloc {
  final _textSubject = BehaviorSubject<String>();
  final _authorSubject = BehaviorSubject<String>();
  final _submitSubject = PublishSubject<void>();

  NewNoteBloc() {
    _submitSubject.listen((_) => _addNote());
  }

  Sink<String> get textSink => _textSubject.sink;

  Sink<String> get authorSink => _authorSubject.sink;

  Sink<void> get submitSink => _submitSubject.sink;

  Observable<bool> get canSubmit =>
      Observable.combineLatest2(_textSubject.stream, _authorSubject.stream,
          (String text, String author) {
        return text.trim().isNotEmpty && author.trim().isNotEmpty;
      });

  void _addNote() async {
    String body = json.encode({
      'text': _textSubject.value,
      'author': _authorSubject.value,
    });
    Map<String, String> headers = {'content-type': 'application/json'};

    http.Response response = await http.post(
      '$apiUrl/addItem',
      body: body,
      headers: headers,
    );
    print(response.statusCode);
  }

  void dispose() {
    _textSubject.close();
    _submitSubject.close();
    _authorSubject.close();
  }
}
