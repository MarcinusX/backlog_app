import 'package:rxdart/rxdart.dart';

class NewNoteBloc {
  final _textSubject = BehaviorSubject<String>();
  final _authorSubject = BehaviorSubject<String>();
  final _submitSubject = PublishSubject<void>();

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

  void dispose() {
    _textSubject.close();
    _authorSubject.close();
    _submitSubject.close();
  }
}
