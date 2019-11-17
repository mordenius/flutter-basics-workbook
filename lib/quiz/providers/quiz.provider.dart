import 'package:flutter/material.dart';
import './../models/question.model.dart';

enum QuizStage { start, progress, result }

class Quiz extends ChangeNotifier {
  QuizStage _currentStage;
  List<Question> _questions;
  int _currentQuestion;
  int _totalScore;

  Quiz(this._questions) {
    _currentQuestion = 0;
    _totalScore = 0;
    _currentStage = QuizStage.start;
  }

  QuizStage get currentStage {
    return _currentStage;
  }

  String get progress {
    return '${_currentQuestion + 1} of ${_questions.length}';
  }

  void start() {
    _currentStage = QuizStage.progress;
    notifyListeners();
  }

  Question getQuestion() {
    return _questions[_currentQuestion];
  }

  void next() {
    _currentQuestion++;

    if (_currentQuestion >= _questions.length) {
      _currentStage = QuizStage.result;
    }

    notifyListeners();
  }

  void reset() {
    _currentQuestion = 0;
    _totalScore = 0;
    _currentStage = QuizStage.start;
    notifyListeners();
  }
}
