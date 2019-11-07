import 'package:flutter/material.dart';

import './question.dart';
import './answer.dart';

class Quiz extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  final List questions = [
    {
      "questionText": "Question one?",
      "answers": ["One", "Two", "Three", "Gour"]
    },
    {
      "questionText": "Question two?",
      "answers": ["One", "Two", "Three", "Gour"]
    }
  ];

  int _currentQuestion = 0;

  void _answerQuestion(String answerText) {
    print('Answer is $answerText');

    setState(() {
      _currentQuestion = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<String, Object> question = questions[_currentQuestion];

    String questionText = question["questionText"];
    List<Widget> answers = _getListAnswers(question["answers"]);

    return Column(children: [
      Question(questionText: questionText),
      Column(children: answers),
    ]);
  }

  List<Widget> _getListAnswers(List<String> answers) {
    List<Widget> answersWidgets = [];

    for (String answer in answers) {
      answersWidgets.add(
        Answer(
          answerText: answer,
          onChoose: this._answerQuestion,
        ),
      );
    }

    return answersWidgets;
  }
}
