import 'package:flutter/material.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AppState();
  }
}

class _AppState extends State<App> {
  List<String> _questions = ["Question one?", "Question 2?"];
  int _currentQuestion = 0;

  void _answerQuestion(String answer) {
    print('Answer is $answer');

    setState(() {
      _currentQuestion = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(title: Text("Title ")),
        body: Column(
          children: [
            Text(_questions[_currentQuestion]),
            _getAnswerVariant("Answer 1"),
            _getAnswerVariant("Answer 2"),
            _getAnswerVariant("Answer 3"),
            _getAnswerVariant("Answer 4")
          ],
        ),
      ),
    );
  }

  Widget _getAnswerVariant(String answer) {
    return RaisedButton(
      child: Text(answer),
      onPressed: () => _answerQuestion(answer),
    );
  }
}
