import 'package:flutter/material.dart';

class App extends StatelessWidget {
  void _answerQuestion(String answer) {
    print('Answer is $answer');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(title: Text("Title ")),
        body: Column(
          children: [
            Text('Question?'),
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
