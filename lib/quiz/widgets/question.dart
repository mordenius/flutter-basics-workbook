import 'package:flutter/material.dart';

import './../models/question.dart';
import './../models/answer.dart';

class QuestionWidget extends StatelessWidget {
  final Question _question;
  final Function(Answer answer) _answerQuestion;

  QuestionWidget(this._question, this._answerQuestion);

  @override
  Widget build(BuildContext context) {
    final List<Widget> answers = _getListAnswers();

    return Column(children: [
      Container(child: Text(_question.text)),
      Column(children: answers),
    ]);
  }

  List<Widget> _getListAnswers() {
    final List<Widget> answersWidgets = [];

    for (Answer answer in _question.answers) {
      answersWidgets.add(
        _AnswerWidget(
          answerText: answer.text,
          onChoose: (_) => this._answerQuestion(answer),
        ),
      );
    }

    return answersWidgets;
  }
}

class _AnswerWidget extends StatelessWidget {
  final String answerText;
  final Function onChoose;

  _AnswerWidget({this.answerText, this.onChoose});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(this.answerText),
      onPressed: () => this.onChoose(answerText),
    );
  }
}
