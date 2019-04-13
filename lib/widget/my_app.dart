import 'package:backlog_app/widget/backlog_list_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Backlog App',
      home: BacklogListPage(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
