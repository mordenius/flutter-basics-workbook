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
  Future<NumberTrivia> getConcreteNumberTrivia(int number) {
    return _getTriviaFromUrl('http://numbertrivia.com/$number');
  }

  @override
  Future<NumberTrivia> getRandomNumberTrivia() async {
    return _getTriviaFromUrl('http://numbertrivia.com/random');
  }

  Future<NumberTrivia> _getTriviaFromUrl(String url) async {
    final http.Response response =
        await client.get(url, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      return NumberTriviaModel.fromJson(json.decode(response.body));
    }

    throw ServerException();
  }
}
