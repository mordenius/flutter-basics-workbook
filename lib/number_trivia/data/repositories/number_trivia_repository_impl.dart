import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_basics_workbook/core/exceptions/exceptions.dart';

import './../../../core/platform/network_info.dart';
import './../../../core/exceptions/failures.dart';
import './../../domain/entities/number_trivia.dart';
import './../../domain/repositories/number_trivia_repository.dart';
import './../datasources/number_trivia_local_data_source.dart';
import './../datasources/number_trivia_remote_data_source.dart';

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
    if (await networkInfo.isConnected) {
      try {
        final remoteData =
            await remoteDataSource.getConcreteNumberTrivia(number);
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

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await remoteDataSource.getRandomNumberTrivia();
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
