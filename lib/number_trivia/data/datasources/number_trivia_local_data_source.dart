import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './../../../core/exceptions/exceptions.dart';
import './../models/number_trivia_model.dart';

abstract class NumberTriviaLocalDataSource {
  Future<NumberTriviaModel> getLastNumberTrivia();
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache);
}

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {
  static const _KEY = 'CACHED_NUMBER_TRIVIA';
  final SharedPreferences sharedPreferences;

  NumberTriviaLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache) {
    // TODO: implement cacheNumberTrivia
    return null;
  }

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() {
    try {
      final cached = sharedPreferences.getString(_KEY);
      if (cached == null) throw CacheException();
      final numberTrivia = NumberTriviaModel.fromJson(json.decode(cached));
      return Future.value(numberTrivia);
    } catch (error) {
      throw CacheException();
    }
  }
}
