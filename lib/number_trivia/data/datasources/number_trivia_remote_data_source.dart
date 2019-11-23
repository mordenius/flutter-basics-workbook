import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_basics_workbook/core/exceptions/exceptions.dart';
import 'package:flutter_basics_workbook/number_trivia/data/models/number_trivia_model.dart';
import 'package:http/http.dart' as http;

import './../../domain/entities/number_trivia.dart';

abstract class NumberTriviaRemoteDataSource {
  Future<NumberTrivia> getConcreteNumberTrivia(int number);
  Future<NumberTrivia> getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  final http.Client client;

  NumberTriviaRemoteDataSourceImpl({@required this.client});

  @override
  Future<NumberTrivia> getConcreteNumberTrivia(int number) async {
    final http.Response response = await client.get(
        'http://numbertrivia.com/$number',
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      return NumberTriviaModel.fromJson(json.decode(response.body));
    }

    throw ServerException();
  }

  @override
  Future<NumberTrivia> getRandomNumberTrivia() async {
    final http.Response response = await client.get(
        'http://numbertrivia.com/random',
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      return NumberTriviaModel.fromJson(json.decode(response.body));
    }

    throw ServerException();
  }
}
