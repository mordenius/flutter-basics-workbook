import './models/question.dart';
import './models/answer.dart';

final questions = [
  Question(
    text: "Question one?",
    answers: [
      Answer(text: "One", score: 1),
      Answer(text: "Two", score: 2),
      Answer(text: "Three", score: 3),
      Answer(text: "Four", score: 4),
    ],
  ),
  Question(
    text: "Question two?",
    answers: [
      Answer(text: "One", score: 4),
      Answer(text: "Two", score: 3),
      Answer(text: "Three", score: 2),
      Answer(text: "Four", score: 1),
    ],
  )
];
