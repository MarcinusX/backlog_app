import 'package:backlog_app/bloc/backlog_list_bloc.dart';
import 'package:backlog_app/bloc/bloc_provider.dart';
import 'package:backlog_app/model/note.dart';
import 'package:backlog_app/widget/note_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

class MockListBloc extends Mock implements BacklogListBloc {}

void main() {
  testWidgets('it builds', (WidgetTester tester) async {
    Note note = Note(1, 'a', 'text', Colors.red, 3);
    Widget widget = MaterialApp(
      home: Scaffold(
        body: BottomLikeRow(
          note: note,
        ),
      ),
    );
    await tester.pumpWidget(widget);
    expect(find.byType(BottomLikeRow), findsOneWidget);
  });

  testWidgets('it shows number of likes', (WidgetTester tester) async {
    Note note = Note(1, 'a', 'text', Colors.red, 3);
    Widget widget = MaterialApp(
      home: Scaffold(
        body: BottomLikeRow(
          note: note,
        ),
      ),
    );
    await tester.pumpWidget(widget);
    expect(find.text('+ 3'), findsOneWidget);
  });

  testWidgets('it shows numbvhgvhgvghver of likes', (WidgetTester tester) async {
    BacklogListBloc bloc = MockListBloc();
    final _notesSubject = BehaviorSubject<Note>();
    when(bloc.likeSink).thenAnswer((_) => _notesSubject.sink);
    Note note = Note(2, 'a', 'text', Colors.red, 3);
    Widget widget = BlocProvider(
      backlogListBloc: bloc,
      child: MaterialApp(
        home: Scaffold(
          body: BottomLikeRow(
            note: note,
          ),
        ),
      ),
    );
    await tester.pumpWidget(widget);
    await tester.tap(find.byType(FlatButton));
    expect(_notesSubject, emits(note));
  });
}
