import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_basics_workbook/core/exceptions/failures.dart';

import './../entities/number_trivia.dart';
import './../repositories/number_trivia_repository.dart';

class GetConcreteNumberTrivia {
  final NumberTriviaRepository repository;

  GetConcreteNumberTrivia(this.repository);

  Future<Either<Failure, NumberTrivia>> call({@required int number}) async {
    return repository.getConcreteNumberTrivia(number);
  }
}
