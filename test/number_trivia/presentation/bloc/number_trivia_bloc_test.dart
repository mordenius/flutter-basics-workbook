import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_basics_workbook/number_trivia/presentation/bloc/bloc.dart';

import 'package:flutter_basics_workbook/core/util/input_converter.dart';
import 'package:flutter_basics_workbook/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_basics_workbook/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:flutter_basics_workbook/number_trivia/domain/usecases/get_random_number_trivia.dart';

class MockGetConcreteTrivia extends Mock implements GetConcreteNumberTrivia {}

class MockGetRandomTrivia extends Mock implements GetRandomNumberTrivia {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  NumberTriviaBloc bloc;

  MockGetConcreteTrivia mockGetConcrete;
  MockGetRandomTrivia mockGetRandom;
  MockInputConverter mockinputConverter;

  setUp(() {
    mockGetConcrete = MockGetConcreteTrivia();
    mockGetRandom = MockGetRandomTrivia();
    mockinputConverter = MockInputConverter();

    bloc = NumberTriviaBloc(
        concrete: mockGetConcrete,
        random: mockGetRandom,
        inputConverter: mockinputConverter);
  });

  test('initialState should be Initial ', () {
    expect(bloc.initialState, equals(InitialNumberTriviaState()));
  });

  group('GetTriviaConcreteNumber', () {
    final tNumberString = '1';
    final tNumberParsed = 1;
    final tNumberTrivia = NumberTrivia(
        number: tNumberParsed, text: "Test Trivia", type: NumberType.trivia);

    test(
        'should call the InputConverter to convert the string to an unsigned integer',
        () async {
      when(mockinputConverter.stringToUnsignedInteger(any))
          .thenReturn(Right(tNumberParsed));

      bloc.add(GetTriviaForConcreteNumber(tNumberString));
      await untilCalled(mockinputConverter.stringToUnsignedInteger(any));

      verify(mockinputConverter.stringToUnsignedInteger(tNumberString));
    });

    test('should emit [Error] when the input is invalid', () async {
      when(mockinputConverter.stringToUnsignedInteger(any))
          .thenReturn(Left(InvalidInputFailure()));

      final expectedStates = [
        InitialNumberTriviaState(),
        ErrorNumberTriviaState(message: INVALID_INPUT_FAILURE_MESSAGE),
      ];

      expectLater(bloc, emitsInOrder(expectedStates));

      bloc.add(GetTriviaForConcreteNumber(tNumberString));
    });
  });
}
