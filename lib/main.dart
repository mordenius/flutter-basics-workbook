import 'package:flutter/material.dart';

import './domain/quiz.dart' as quizlib;

import './view/App.dart';

var quizlibLogic = quizlib.QuizLogic([
  quizlib.Question(
    text: "Question one?",
    answers: [
      quizlib.Answer(text: "One", score: 1),
      quizlib.Answer(text: "Two", score: 2),
      quizlib.Answer(text: "Three", score: 3),
      quizlib.Answer(text: "Four", score: 4),
    ],
  ),
  quizlib.Question(
    text: "Question two?",
    answers: [
      quizlib.Answer(text: "One", score: 4),
      quizlib.Answer(text: "Two", score: 3),
      quizlib.Answer(text: "Three", score: 2),
      quizlib.Answer(text: "Four", score: 1),
    ],
  )
]);

class Domain {
  final quizlib.QuizLogic quiz = quizlibLogic;
}

void main() => runApp(App(Domain()));
