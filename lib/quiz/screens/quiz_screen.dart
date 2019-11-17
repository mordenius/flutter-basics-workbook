import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './../providers/quiz.provider.dart';
import './../models/question.model.dart';
import './../models/answer.model.dart';

class QuizScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Quiz quiz = Provider.of<Quiz>(context);
    Question question = quiz.getQuestion();

    final List<Widget> answers =
        _getListAnswers(question.answers, quiz.next);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 32),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              quiz.progress,
              style: Theme.of(context).textTheme.title.copyWith(fontSize: 32),
            ),
            SizedBox(
              height: 32,
            ),
            Text(
              question.text,
              style: Theme.of(context).textTheme.title.copyWith(fontSize: 16),
            ),
            Column(children: answers),
          ],
        ),
      ),
    );
  }

  List<Widget> _getListAnswers(List<Answer> answers, onChoose) {
    final List<Widget> answersWidgets = [];

    for (Answer answer in answers) {
      answersWidgets.add(
        RaisedButton(
          child: Text(answer.text),
          onPressed: () => onChoose(answer),
        ),
      );
    }

    return answersWidgets;
  }
}
