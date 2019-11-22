import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_basics_workbook/core/exceptions/exceptions.dart';
import 'package:flutter_basics_workbook/core/exceptions/failures.dart';
import 'package:flutter_basics_workbook/core/network/network_info.dart';
import 'package:flutter_basics_workbook/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_basics_workbook/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:flutter_basics_workbook/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:flutter_basics_workbook/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:flutter_basics_workbook/number_trivia/domain/entities/number_trivia.dart';

class MockRemoteDataSource extends Mock
    implements NumberTriviaRemoteDataSource {}

class MockLocalDataSource extends Mock implements NumberTriviaLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  NumberTriviaRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();

    repository = NumberTriviaRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localeDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  final tNumber = 1;
  final tNumberTriviaModel =
      NumberTriviaModel(text: 'Test Text', number: 1, type: NumberType.trivia);
  final NumberTrivia tNumberTrivia = tNumberTriviaModel;

  group('getConcreteNumberTrivia', () {
    test('shoud check if the device is online', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      repository.getConcreteNumberTrivia(tNumber);

      verify(mockNetworkInfo.isConnected);
    });
  });

  runTestsOnline(() {
    test(
        'shoud return remote data when the call to remote data source is successful',
        () async {
      when(mockRemoteDataSource.getConcreteNumberTrivia(any))
          .thenAnswer((_) async => tNumberTriviaModel);

      final result = await repository.getConcreteNumberTrivia(tNumber);

      verify(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
      expect(result, equals(Right(tNumberTrivia)));
    });

    test(
        'shoud cache remote data when the call to remote data source is successful',
        () async {
      when(mockRemoteDataSource.getConcreteNumberTrivia(any))
          .thenAnswer((_) async => tNumberTriviaModel);

      await repository.getConcreteNumberTrivia(tNumber);

      verify(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
      verify(mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel));
    });

    test(
        'shoud return server failure when the call to remote data source is unsuccessful',
        () async {
      when(mockRemoteDataSource.getConcreteNumberTrivia(any))
          .thenThrow(ServerException());

      final result = await repository.getConcreteNumberTrivia(tNumber);

      verify(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
      verifyZeroInteractions(mockLocalDataSource);
      expect(result, equals(Left(ServerFailure())));
    });

    test(
        'shoud return cache failure when the cache to local data source is unsuccessful',
        () async {
      when(mockRemoteDataSource.getConcreteNumberTrivia(any))
          .thenAnswer((_) async => tNumberTriviaModel);
      when(mockLocalDataSource.cacheNumberTrivia(any))
          .thenThrow(CacheException());

      final result = await repository.getConcreteNumberTrivia(tNumber);

      verify(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
      verify(mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel));
      expect(result, equals(Left(CacheFailure())));
    });
  });

  runTestsOffline(() {
    test(
        'should return last locally cached data when the cached data is present',
        () async {
      when(mockLocalDataSource.getLastNumberTrivia())
          .thenAnswer((_) async => tNumberTriviaModel);

      final result = await repository.getConcreteNumberTrivia(tNumber);

      verifyZeroInteractions(mockRemoteDataSource);
      verify(mockLocalDataSource.getLastNumberTrivia());
      expect(result, equals(Right(tNumberTriviaModel)));
    });

    test('should return cache failure when there is no cached data present',
        () async {
      when(mockLocalDataSource.getLastNumberTrivia())
          .thenThrow(CacheException());

      final result = await repository.getConcreteNumberTrivia(tNumber);

      verifyZeroInteractions(mockRemoteDataSource);
      verify(mockLocalDataSource.getLastNumberTrivia());
      expect(result, equals(Left(CacheFailure())));
    });
  });

  group('getRandomNumberTrivia', () {
    test('shoud check if the device is online', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      repository.getRandomNumberTrivia();

      verify(mockNetworkInfo.isConnected);
    });
  });

  runTestsOnline(() {
    test(
        'shoud return remote data when the call to remote data source is successful',
        () async {
      when(mockRemoteDataSource.getRandomNumberTrivia())
          .thenAnswer((_) async => tNumberTriviaModel);

      final result = await repository.getRandomNumberTrivia();

      verify(mockRemoteDataSource.getRandomNumberTrivia());
      expect(result, equals(Right(tNumberTrivia)));
    });

    test(
        'shoud cache remote data when the call to remote data source is successful',
        () async {
      when(mockRemoteDataSource.getRandomNumberTrivia())
          .thenAnswer((_) async => tNumberTriviaModel);

      await repository.getRandomNumberTrivia();

      verify(mockRemoteDataSource.getRandomNumberTrivia());
      verify(mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel));
    });

    test(
        'shoud return server failure when the call to remote data source is unsuccessful',
        () async {
      when(mockRemoteDataSource.getRandomNumberTrivia())
          .thenThrow(ServerException());

      final result = await repository.getRandomNumberTrivia();

      verify(mockRemoteDataSource.getRandomNumberTrivia());
      verifyZeroInteractions(mockLocalDataSource);
      expect(result, equals(Left(ServerFailure())));
    });

    test(
        'shoud return cache failure when the cache to local data source is unsuccessful',
        () async {
      when(mockRemoteDataSource.getRandomNumberTrivia())
          .thenAnswer((_) async => tNumberTriviaModel);
      when(mockLocalDataSource.cacheNumberTrivia(any))
          .thenThrow(CacheException());

      final result = await repository.getRandomNumberTrivia();

      verify(mockRemoteDataSource.getRandomNumberTrivia());
      verify(mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel));
      expect(result, equals(Left(CacheFailure())));
    });
  });

  runTestsOffline(() {
    test(
        'should return last locally cached data when the cached data is present',
        () async {
      when(mockLocalDataSource.getLastNumberTrivia())
          .thenAnswer((_) async => tNumberTriviaModel);

      final result = await repository.getRandomNumberTrivia();

      verifyZeroInteractions(mockRemoteDataSource);
      verify(mockLocalDataSource.getLastNumberTrivia());
      expect(result, equals(Right(tNumberTriviaModel)));
    });

    test('should return cache failure when there is no cached data present',
        () async {
      when(mockLocalDataSource.getLastNumberTrivia())
          .thenThrow(CacheException());

      final result = await repository.getRandomNumberTrivia();

      verifyZeroInteractions(mockRemoteDataSource);
      verify(mockLocalDataSource.getLastNumberTrivia());
      expect(result, equals(Left(CacheFailure())));
    });
  });
}
