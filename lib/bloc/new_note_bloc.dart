import 'dart:convert';

import 'package:backlog_app/constants.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

///Bloc for [AddNotePage]
class NewNoteBloc {
  ///Contains state of the submit request
  final _submitRequestStateSubject = BehaviorSubject<RequestState>();

  ///Contains string note from input
  final _noteSubject = BehaviorSubject<String>();

  ///Contains string author from input
  final _authorSubject = BehaviorSubject<String>();

  ///Triggers submit request
  final _submitSubject = PublishSubject<void>();

  NewNoteBloc() {
    _submitSubject.listen(_onSubmit);
  }

  ///Pass note's text
  Sink<String> get noteSink => _noteSubject.sink;

  ///Pass note's author
  Sink<String> get authorSink => _authorSubject.sink;

  ///Submit the addition request
  Sink<void> get submit => _submitSubject.sink;

  ///Returns the state of the request
  Observable<RequestState> get requestState =>
      _submitRequestStateSubject.stream;

  ///Whether user can submit
  Observable<bool> get canSubmit => Observable.combineLatest2(
        _noteSubject,
        _authorSubject,
        (String note, String author) =>
            (note?.trim()?.isNotEmpty ?? false) &&
            (author?.trim()?.isNotEmpty ?? false),
      );

  ///When user submits
  void _onSubmit(_) async {
    _submitRequestStateSubject.add(RequestState.processing);
    try {
      http.Response response = await _requestAddingANote();
      if (response.statusCode == 200) {
        _submitRequestStateSubject.add(RequestState.success);
      } else {
        _submitRequestStateSubject.add(RequestState.error);
      }
    } catch (e) {
      print(e);
      _submitRequestStateSubject.add(RequestState.error);
    }
  }

  ///Do actual request
  Future<http.Response> _requestAddingANote() async {
    String body = json.encode({
      'author': _authorSubject.value,
      'text': _noteSubject.value,
    });
    Map<String, String> headers = {
      'content-type': 'application/json',
    };
    http.Response response = await http.post(
      '$https$domain/addItem',
      body: body,
      headers: headers,
    );
    print(response.body);
    return response;
  }

  void dispose() {
    _noteSubject.close();
    _authorSubject.close();
    _submitSubject.close();
    _submitRequestStateSubject.close();
  }
}

enum RequestState { processing, success, error, idle }
