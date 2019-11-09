import 'package:flutter/material.dart';

import './quiz/quiz.dart';
import './expenses/expenses.dart';
import 'expenses/append_transaction.dart';

class Router extends StatefulWidget {
  final dynamic _domain;

  Router(this._domain);

  @override
  _RouterState createState() =>
      _RouterState([Quiz(_domain.quiz), Expenses(_domain.expenses)]);
}

class _RouterState extends State<Router> {
  final List<Widget> _sections;
  int _currentSection = 1;

  _RouterState(this._sections);

  _startAddNew(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            child: AppendTransaction(null),
            behavior: HitTestBehavior.opaque,
            onTap: () {},
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            _startAddNew(context);
          }),
      appBar: AppBar(title: Text("Title "), actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            _startAddNew(context);
          },
        )
      ]),
      body: Builder(builder: (context) => this._sections[this._currentSection]),
    );
  }
}
