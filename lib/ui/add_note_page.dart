import 'dart:async';

import 'package:backlog_app/bloc/new_note_bloc.dart';
import 'package:flutter/material.dart';

///A page for new note
class AddNotePage extends StatefulWidget {
  final NewNoteBloc bloc;

  const AddNotePage({Key key, @required this.bloc}) : super(key: key);

  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  StreamSubscription subscription;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add an item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<RequestState>(
          stream: widget.bloc.requestState,
          initialData: RequestState.idle,
          builder: (context, stateSnapshot) {
            if (stateSnapshot.data == RequestState.processing) {
              return Center(child: CircularProgressIndicator());
            }
            return AddNotePageBody(bloc: widget.bloc);
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    //if request state is success, hide the page
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

///Body of add note page
class AddNotePageBody extends StatelessWidget {
  final NewNoteBloc bloc;

  const AddNotePageBody({Key key, @required this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          maxLines: 3,
          decoration: InputDecoration(filled: true, labelText: 'Item text'),
          onChanged: (s) => bloc.noteSink.add(s),
        ),
        SizedBox(height: 16),
        TextField(
          decoration: InputDecoration(filled: true, labelText: 'Author'),
          onChanged: (s) => bloc.authorSink.add(s),
        ),
        SizedBox(height: 16),
        SendButton(bloc: bloc)
      ],
    );
  }
}

///Button to create new note
class SendButton extends StatelessWidget {
  final NewNoteBloc bloc;

  const SendButton({Key key, @required this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: bloc.canSubmit,
      initialData: false,
      builder: (context, canSubmitSnapshot) {
        VoidCallback onPressed =
            canSubmitSnapshot.data ? () => bloc.submit.add(null) : null;
        return SizedBox(
          width: double.infinity,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            color: Theme.of(context).primaryColor,
            onPressed: onPressed,
            child: Text(
              'SEND',
              style: Theme.of(context).primaryTextTheme.button,
            ),
          ),
        );
      },
    );
  }
}
