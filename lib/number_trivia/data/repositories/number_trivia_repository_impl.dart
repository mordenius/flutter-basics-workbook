import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_basics_workbook/core/exceptions/exceptions.dart';

import './../../../core/network/network_info.dart';
import './../../../core/exceptions/failures.dart';
import './../../domain/entities/number_trivia.dart';
import './../../domain/repositories/number_trivia_repository.dart';
import './../datasources/number_trivia_local_data_source.dart';
import './../datasources/number_trivia_remote_data_source.dart';

typedef Future<NumberTrivia> _ConcreteOrRandomCallback();

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localeDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl(
      {@required this.remoteDataSource,
      @required this.localeDataSource,
      @required this.networkInfo});

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(
      int number) async {
    final sourceCall = () => remoteDataSource.getConcreteNumberTrivia(number);
    return _gettingTriviaHandle(sourceCall);
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    final sourceCall = () => remoteDataSource.getRandomNumberTrivia();
    return _gettingTriviaHandle(sourceCall);
  }

  Future<Either<Failure, NumberTrivia>> _gettingTriviaHandle(
      _ConcreteOrRandomCallback sourceCall,
      [int number]) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await sourceCall();
        localeDataSource.cacheNumberTrivia(remoteData);
        return Right(remoteData);
      } on ServerException {
        return Left(ServerFailure());
      } on CacheException {
        return Left(CacheFailure());
      }
    } else {
      try {
        final cachedData = await localeDataSource.getLastNumberTrivia();
        return Right(cachedData);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
