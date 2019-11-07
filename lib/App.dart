import 'package:flutter/material.dart';
import './quiz/quiz.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AppState();
  }
}

class _AppState extends State<App> {
  final List<Widget> _sections = [Quiz()];
  int _currentSection = 0;

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
