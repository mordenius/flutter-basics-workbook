import './../models/number_trivia_model.dart';

abstract class NumberTriviaLocalDataSource {
  Future<NumberTriviaModel> getLastNumberTrivia(NumberTriviaModel triviaToCache);
  Future<void> cacheNumberTrivia(int number);
}
