import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
          appBar: AppBar(title: Text("Title ")),
          body: this._sections[this._currentSection]),
    );
  }
}
