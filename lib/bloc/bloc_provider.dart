import 'package:backlog_app/bloc/backlog_list_bloc.dart';
import 'package:flutter/material.dart';

class BlocProvider extends InheritedWidget {
  final BacklogListBloc backlogListBloc;

  const BlocProvider({
    Key key,
    @required this.backlogListBloc,
    @required Widget child,
  })
      : assert(child != null),
        super(key: key, child: child);

  static BlocProvider of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(BlocProvider) as BlocProvider;
  }

  @override
  bool updateShouldNotify(BlocProvider old) {
    return false;
  }
}