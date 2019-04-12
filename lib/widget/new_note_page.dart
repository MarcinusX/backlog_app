import 'dart:async';

import 'package:backlog_app/bloc/new_note_bloc.dart';
import 'package:flutter/material.dart';

class NewNotePage extends StatefulWidget {
  final NewNoteBloc bloc;

  const NewNotePage({Key key, @required this.bloc}) : super(key: key);

  @override
  _NewNotePageState createState() => _NewNotePageState();
}

class _NewNotePageState extends State<NewNotePage> {
  StreamSubscription subscription;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add an item'),
      ),
      body: StreamBuilder<RequestState>(
          stream: widget.bloc.requestState,
          initialData: RequestState.idle,
          builder: (context, snapshot) {
            if (snapshot.data == RequestState.processing) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      labelText: 'Item text',
                    ),
                    maxLines: 3,
                    onChanged: (s) => widget.bloc.textSink.add(s),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      labelText: 'Author',
                    ),
                    onChanged: (s) => widget.bloc.authorSink.add(s),
                  ),
                  SizedBox(height: 16),
                  _SendButton(bloc: widget.bloc),
                ],
              ),
            );
          }),
    );
  }

  @override
  void initState() {
    super.initState();
    subscription = widget.bloc.requestState.listen((state) {
      if (state == RequestState.success) {
        Navigator.of(context).pop(true);
      }
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}

class _SendButton extends StatelessWidget {
  final NewNoteBloc bloc;

  const _SendButton({Key key, @required this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: bloc.canSubmit,
        initialData: false,
        builder: (context, snapshot) {
          return SizedBox(
            width: double.infinity,
            height: 40,
            child: RaisedButton(
              color: Colors.blue,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: Text('SEND'),
              onPressed: snapshot.data ? () => _onPressed(context) : null,
            ),
          );
        });
  }

  void _onPressed(BuildContext context) {
    bloc.submitSink.add(null);
  }
}
