import 'dart:convert';
import 'dart:io';

import 'package:backlog_app/constants.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

class NewNoteBloc {
  final _textSubject = BehaviorSubject<String>();
  final _authorSubject = BehaviorSubject<String>();
  final _submitSubject = PublishSubject<void>();
  final _requestStateSubject = PublishSubject<RequestState>();

  NewNoteBloc() {
    _submitSubject.listen((_) => _addNewNote());
  }

  Sink<String> get textSink => _textSubject.sink;

  Sink<String> get authorSink => _authorSubject.sink;

  Sink<void> get submitSink => _submitSubject.sink;

  Observable<bool> get canSubmit => Observable.combineLatest2(
        _textSubject.stream,
        _authorSubject.stream,
        (String text, String author) {
          return text.trim().isNotEmpty && author.trim().isNotEmpty;
        },
      );

  Observable<RequestState> get requestState => _requestStateSubject.stream;

  void _addNewNote() async {
    _requestStateSubject.add(RequestState.processing);

    String author = _authorSubject.value;
    String text = _textSubject.value;
    String body = json.encode({
      'text': text,
      'author': author,
    });
    Map<String, String> headers = {'content-type': 'application/json'};
    http.Response response = await http.post(
      '$https$apiDomain/addItem',
      body: body,
      headers: headers,
    );
    print(response.body);
    if (response.statusCode == HttpStatus.ok) {
      _requestStateSubject.add(RequestState.success);
    } else {
      _requestStateSubject.add(RequestState.error);
    }
  }

  void dispose() {
    _textSubject.close();
    _authorSubject.close();
    _submitSubject.close();
    _requestStateSubject.close();
  }
}

enum RequestState { idle, processing, error, success }
