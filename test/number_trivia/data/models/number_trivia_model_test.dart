import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_basics_workbook/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_basics_workbook/number_trivia/data/models/number_trivia_model.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  final tNumberTriviaModel =
      NumberTriviaModel(number: 1, text: 'Test Text', type: NumberType.trivia);

  test(('should be a subclass of NumberTrivia Entity'), () async {
    expect(tNumberTriviaModel, isA<NumberTrivia>());
  });

  group('from JSON', () {
    test('shoud return a valid model when the JSON number is an integer',
        () async {
      final Map<String, dynamic> jsonMap = json.decode(fixture('trivia.json'));

      final result = NumberTriviaModel.fromJson(jsonMap);

      expect(result, tNumberTriviaModel);
    });

    test('shoud return a valid model when the JSON number is an double',
        () async {
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('trivia_double.json'));

      final result = NumberTriviaModel.fromJson(jsonMap);

      expect(result, tNumberTriviaModel);
    });
  });

  group('to JSON', () {
    test('shoud return a JSON map containing the proper data', () async {
      final Map<String, dynamic> jsonMap = json.decode(fixture('trivia.json'));

      final result = NumberTriviaModel.fromJson(jsonMap);

      expect(result, tNumberTriviaModel);
    });
  });
}
