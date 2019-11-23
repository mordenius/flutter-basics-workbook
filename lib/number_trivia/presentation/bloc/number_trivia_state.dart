import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import './../../domain/entities/number_trivia.dart';

abstract class NumberTriviaState extends Equatable {
  NumberTriviaState([List props = const <dynamic>[]]) : super(props);
}

class InitialNumberTriviaState extends NumberTriviaState {}

class LoadingNumberTriviaState extends NumberTriviaState {}

class LoadedNumberTriviaState extends NumberTriviaState {
  final NumberTrivia trivia;

  LoadedNumberTriviaState({@required this.trivia}) : super([trivia]);
}

class ErrorNumberTriviaState extends NumberTriviaState {
  final String message;

  ErrorNumberTriviaState({@required this.message}) : super([message]);
}
