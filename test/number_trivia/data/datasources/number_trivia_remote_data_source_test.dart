import 'dart:convert';

import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_basics_workbook/core/exceptions/exceptions.dart';
import 'package:flutter_basics_workbook/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:flutter_basics_workbook/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_basics_workbook/number_trivia/domain/entities/number_trivia.dart';

import '../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  NumberTriviaRemoteDataSourceImpl dataSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = NumberTriviaRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMoskRequestSuccess() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));
  }

  void setUpMoskRequestFailure() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Request failed', 404));
  }

  group('getConcreteNumberTrivia', () {
    final tNumber = 1;
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

    test('''should perform a GET request on a URL with number 
        being the endpoint and with application/json header''', () async {
      setUpMoskRequestSuccess();

      dataSource.getConcreteNumberTrivia(tNumber);

      verify(mockHttpClient.get('http://numbertrivia.com/$tNumber',
          headers: {'Content-Type': 'application/json'}));
    });

    test('should return a NumberTrivia when the response code is 200 (success)',
        () async {
      setUpMoskRequestSuccess();

      final result = await dataSource.getConcreteNumberTrivia(tNumber);

      expect(result, isA<NumberTrivia>());
      expect(result, equals(tNumberTriviaModel));
    });

    test(
        'should throw a Server Exception when the response code is 404 or other (failure)',
        () async {
      setUpMoskRequestFailure();

      final result = dataSource.getConcreteNumberTrivia;

      expect(() async => await result(tNumber),
          throwsA(TypeMatcher<ServerException>()));
    });
  });

  group('getRandomNumberTrivia', () {
    final tNumber = 1;
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

    test('''should perform a GET request on a URL with number 
        being the endpoint and with application/json header''', () async {
      setUpMoskRequestSuccess();

      dataSource.getRandomNumberTrivia();

      verify(mockHttpClient.get('http://numbertrivia.com/random',
          headers: {'Content-Type': 'application/json'}));
    });

    test('should return a NumberTrivia when the response code is 200 (success)',
        () async {
      setUpMoskRequestSuccess();

      final result = await dataSource.getRandomNumberTrivia();

      expect(result, isA<NumberTrivia>());
      expect(result, equals(tNumberTriviaModel));
    });

    test(
        'should throw a Server Exception when the response code is 404 or other (failure)',
        () async {
      setUpMoskRequestFailure();

      final result = dataSource.getRandomNumberTrivia;

      expect(
          () async => await result(), throwsA(TypeMatcher<ServerException>()));
    });
  });
}
