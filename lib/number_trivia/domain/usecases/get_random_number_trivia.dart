import 'package:dartz/dartz.dart';

import 'package:flutter_basics_workbook/core/exceptions/failures.dart';
import 'package:flutter_basics_workbook/core/usecase/usecase.dart';

import './../entities/number_trivia.dart';
import './../repositories/number_trivia_repository.dart';

class GetRandomNumberTrivia implements UseCase<NumberTrivia, NoParams> {
  final NumberTriviaRepository repository;

  GetRandomNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams params) async {
    return repository.getRandomNumberTrivia();
  }
}
