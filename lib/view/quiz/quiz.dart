import 'package:flutter/material.dart';
import 'package:flutter_basics_workbook/domain/quiz.dart' as quiz;

import './question.dart';
import './answer.dart';

class Quiz extends StatefulWidget {
  final quiz.QuizLogic _logic;

  Quiz(this._logic);

  @override
  State<StatefulWidget> createState() {
    return _QuizState(_logic);
  }
}

class _QuizState extends State<Quiz> {
  final quiz.QuizLogic _logic;

  _QuizState(this._logic);

  void _answerQuestion(String answerText) {
    print('Answer is $answerText');

    setState(() {
      _logic.next();
    });
  }

  void _reset() {
    setState(() {
      _logic.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_logic.isDone()) {
      return Column(children: [
        Text("All Done"),
        RaisedButton(
          child: Text("Reset"),
          onPressed: _reset,
        )
      ]);
    }

    final quiz.Question question = _logic.getQuestion();
    final List<Widget> answers = _getListAnswers(question.answers);

    return Column(children: [
      Question(questionText: question.text),
      Column(children: answers),
    ]);
  }

  List<Widget> _getListAnswers(List<quiz.Answer> answers) {
    final List<Widget> answersWidgets = [];

    for (quiz.Answer answer in answers) {
      answersWidgets.add(
        Answer(
          answerText: answer.text,
          onChoose: this._answerQuestion,
        ),
      );
    }

    return answersWidgets;
  }
}
