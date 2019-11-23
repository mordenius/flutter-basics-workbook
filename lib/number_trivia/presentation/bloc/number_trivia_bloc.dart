import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import './../../../core/exceptions/failures.dart';
import './../../../core/usecase/usecase.dart';
import './../../../core/util/input_converter.dart';
import './../../domain/entities/number_trivia.dart';
import './../../domain/usecases/get_concrete_number_trivia.dart';
import './../../domain/usecases/get_random_number_trivia.dart';
import './bloc.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaBloc({
    @required GetConcreteNumberTrivia concrete,
    @required GetRandomNumberTrivia random,
    @required this.inputConverter,
  })  : assert(concrete != null),
        assert(random != null),
        assert(inputConverter != null),
        getConcreteNumberTrivia = concrete,
        getRandomNumberTrivia = random;

  @override
  NumberTriviaState get initialState => InitialNumberTriviaState();

  @override
  Stream<NumberTriviaState> mapEventToState(
    NumberTriviaEvent event,
  ) async* {
    if (event is GetTriviaForConcreteNumber) {
      final inputEither =
          inputConverter.stringToUnsignedInteger(event.numberString);
      yield* inputEither.fold((failure) async* {
        yield ErrorNumberTriviaState(message: INVALID_INPUT_FAILURE_MESSAGE);
      }, (integer) async* {
        yield* _getTrivia(
            () async => await getConcreteNumberTrivia(Params(number: integer)));
      });
    } else if (event is GetTriviaForRandomNumber) {
      yield* _getTrivia(() async => await getRandomNumberTrivia(NoParams()));
    }
  }

  Stream<NumberTriviaState> _getTrivia(
      Future<Either<Failure, NumberTrivia>> Function() call) async* {
    yield LoadingNumberTriviaState();
    final failureOrTrivia = await call();

    yield* failureOrTrivia.fold((failure) async* {
      yield ErrorNumberTriviaState(message: _mapFailureToMessage(failure));
    }, (numberTrivia) async* {
      yield LoadedNumberTriviaState(trivia: numberTrivia);
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
