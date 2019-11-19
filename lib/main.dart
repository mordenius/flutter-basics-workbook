import 'package:flutter_config/flutter_config.dart';
import 'package:flutter/material.dart';
import './great_places/great_places.dart';

import './domain/quiz.dart' as quizlib;
import './domain/expenses.dart' as expenseslib;

// import './view/App.dart';

// var quizlibLogic = quizlib.QuizLogic([
//   quizlib.Question(
//     text: "Question one?",
//     answers: [
//       quizlib.Answer(text: "One", score: 1),
//       quizlib.Answer(text: "Two", score: 2),
//       quizlib.Answer(text: "Three", score: 3),
//       quizlib.Answer(text: "Four", score: 4),
//     ],
//   ),
//   quizlib.Question(
//     text: "Question two?",
//     answers: [
//       quizlib.Answer(text: "One", score: 4),
//       quizlib.Answer(text: "Two", score: 3),
//       quizlib.Answer(text: "Three", score: 2),
//       quizlib.Answer(text: "Four", score: 1),
//     ],
//   )
// ]);

// var expensesLogic = expenseslib.ExpensesLogic();

// class Domain {
//   final quizlib.QuizLogic quiz = quizlibLogic;
//   final expenseslib.ExpensesLogic expenses = expensesLogic;
// }

Future<void> main() async {
  await FlutterConfig.loadEnvVariables();

  runApp(GreatPlacesApp());
}
