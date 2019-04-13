import 'package:backlog_app/bloc/backlog_list_bloc.dart';
import 'package:backlog_app/bloc/bloc_provider.dart';
import 'package:backlog_app/widget/backlog_list_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  BacklogListBloc backlogListBloc;


  @override
  void initState() {
    super.initState();
    backlogListBloc = BacklogListBloc();
    backlogListBloc.requestNotesSink.add(null);
  }


  @override
  void dispose() {
    backlogListBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      backlogListBloc: backlogListBloc,
      child: MaterialApp(
        title: 'Backlog App',
        home: BacklogListPage(),
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
