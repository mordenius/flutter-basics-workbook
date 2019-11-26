import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './../providers/quiz.dart';

import './../widgets/question.dart';

class QuizScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: Consumer<Quiz>(
        builder: (ctx, quiz, _) {
          if (quiz.isDone()) {
            return _getResult(quiz.reset);
          }

          return QuestionWidget(
            quiz.getQuestion(),
            (_) => quiz.next(),
          );
        },
      ),
    );
  }

  Widget _getResult(Function reset) {
    return Column(children: [
      Text("All Done"),
      RaisedButton(
        child: Text("Reset"),
        onPressed: reset,
      )
    ]);
  }
}
