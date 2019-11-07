import 'package:flutter/material.dart';

class App extends StatelessWidget {
  void answerQuestion(String answer) {
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
            getAnswerVariant("Answer 1"),
            getAnswerVariant("Answer 2"),
            getAnswerVariant("Answer 3"),
            getAnswerVariant("Answer 4")
          ],
        ),
      ),
    );
  }

  Widget getAnswerVariant(String answer) {
    return RaisedButton(
      child: Text(answer),
      onPressed: () => answerQuestion(answer),
    );
  }
}
