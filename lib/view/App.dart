import 'package:flutter/material.dart';
import 'package:flutter_basics_workbook/view/expenses/append_transaction.dart';
import './quiz/quiz.dart';
import './expenses/expenses.dart';

class App extends StatefulWidget {
  final dynamic _domain;

  App(this._domain);

  @override
  State<StatefulWidget> createState() {
    return _AppState([Quiz(_domain.quiz), Expenses(_domain.expenses)]);
  }
}

class _AppState extends State<App> {
  final List<Widget> _sections;
  int _currentSection = 1;

  _AppState(this._sections);

  // void _changeSection(String answer) {
  //   print('Answer is $answer');

  //   setState(() {
  //     _currentSection = 1;
  //   });
  // }

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
    return MaterialApp(
      theme: ThemeData(
          fontFamily: "Quicksand",
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.dark().textTheme.copyWith(
                    title: TextStyle(
                      fontFamily: "Quicksand",
                      fontSize: 18,
                    ),
                  ))),
      home: Scaffold(
          appBar: AppBar(title: Text("Title ")),
          body: this._sections[this._currentSection]),
    );
  }
}
