import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_basics_workbook/core/platform/network_info.dart';
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

  group('device is online', () {
    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    });

    test(
        'shoud return remote data when the call to remote data source is successful',
        () async {
      when(mockRemoteDataSource.getConcreteNumberTrivia(any))
          .thenAnswer((_) async => tNumberTriviaModel);

      final result = await repository.getConcreteNumberTrivia(tNumber);

      verify(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
      expect(result, equals(Right(tNumberTrivia)));
    });
  });

  group('device is offline', () {
    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
    });
  });
}
