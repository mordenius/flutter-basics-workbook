part of quiz;

class Answer {
  final String text;
  final int score;

  Answer({this.text, this.score});
}

class Question {
  final String text;
  final List<Answer> answers;

  Question({this.text, this.answers});
}

class QuizResult {
  final int score;

  QuizResult({this.score});
}

class QuizLogic {
  int _currentQuestion;
  int _totalScore;
  bool _isDone;

  final List<Question> _question;

  QuizLogic(this._question) {
    _currentQuestion = 0;
    _totalScore = 0;
    _isDone = _question.length < 1;
  }

  void reset() {
    _currentQuestion = 0;
    _totalScore = 0;
    _isDone = false;
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
      return;
    }

    _isDone = true;
  }

  bool isDone() {
    return _isDone;
  }
}
