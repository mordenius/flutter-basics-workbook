import 'package:dartz/dartz.dart';
import 'package:flutter_basics_workbook/core/exceptions/failures.dart';
import './../entities/number_trivia.dart';

abstract class NumberTriviaRepository {
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number);
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();
}
