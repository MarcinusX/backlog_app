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
        title: Text('Add note :)'),
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
                      fillColor: Colors.yellow,
                      labelText: 'Note text',
                    ),
                    maxLines: 4,
                    onChanged: (text) => widget.bloc.textSink.add(text),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.yellow,
                      labelText: 'Author',
                    ),
                    onChanged: (author) => widget.bloc.authorSink.add(author),
                  ),
                  SizedBox(height: 8),
                  SendButton(bloc: widget.bloc),
                ],
              ),
            );
          }),
    );
  }

  @override
  void initState() {
    super.initState();
    subscription = widget.bloc.requestState.listen((requestState) {
      if (requestState == RequestState.success) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }


}

class SendButton extends StatelessWidget {
  final NewNoteBloc bloc;

  const SendButton({Key key, @required this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: bloc.canSubmit,
        initialData: false,
        builder: (context, snapshot) {
          return Container(
            width: double.infinity,
            child: RaisedButton(
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              child: Text('SEND'),
              onPressed: snapshot.data ? () => _onPressed(context) : null,
            ),
          );
        });
  }

  _onPressed(BuildContext context) {
    bloc.submitSink.add(null);
  }
}
