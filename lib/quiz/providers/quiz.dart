import 'package:flutter/foundation.dart';

import './../models/question.dart';
import './../models/quiz_result.dart';

class Quiz with ChangeNotifier {
  int _currentQuestion;
  int _totalScore;
  bool _isDone;

  final List<Question> _question;

  Quiz(this._question) {
    _currentQuestion = 0;
    _totalScore = 0;
    _isDone = _question.length < 1;
  }

  void reset() {
    _currentQuestion = 0;
    _totalScore = 0;
    _isDone = false;
    notifyListeners();
  }

  QuizResult getResult() {
    return QuizResult(score: _totalScore);
  }

  Question getQuestion() {
    return _question[_currentQuestion];
  }

  void next() {
    _currentQuestion++;

    if (_currentQuestion < _question.length) {
      notifyListeners();
      return;
    }

    _isDone = true;
    notifyListeners();
  }

  bool isDone() {
    return _isDone;
  }
}
