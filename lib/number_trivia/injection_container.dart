import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:data_connection_checker/data_connection_checker.dart';

import './../core/network/network_info.dart';
import './../core/util/input_converter.dart';

import 'data/datasources/number_trivia_local_data_source.dart';
import 'data/datasources/number_trivia_remote_data_source.dart';
import 'data/repositories/number_trivia_repository_impl.dart';
import 'domain/repositories/number_trivia_repository.dart';
import 'domain/usecases/get_random_number_trivia.dart';
import 'domain/usecases/get_concrete_number_trivia.dart';
import 'presentation/bloc/number_trivia_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  // Features
  serviceLocator.registerFactory(() {
    return NumberTriviaBloc(
      concrete: serviceLocator(),
      random: serviceLocator(),
      inputConverter: serviceLocator(),
    );
  });

  serviceLocator.registerLazySingleton(() {
    return GetConcreteNumberTrivia(serviceLocator());
  });
  serviceLocator.registerLazySingleton(() {
    return GetRandomNumberTrivia(serviceLocator());
  });

  // Repository
  serviceLocator.registerLazySingleton<NumberTriviaRepository>(() {
    return NumberTriviaRepositoryImpl(
      localeDataSource: serviceLocator(),
      remoteDataSource: serviceLocator(),
      networkInfo: serviceLocator(),
    );
  });

  // Data Sources
  serviceLocator.registerLazySingleton<NumberTriviaLocalDataSource>(() {
    return NumberTriviaLocalDataSourceImpl(sharedPreferences: serviceLocator());
  });
  serviceLocator.registerLazySingleton<NumberTriviaRemoteDataSource>(() {
    return NumberTriviaRemoteDataSourceImpl(client: serviceLocator());
  });

  // Core
  serviceLocator.registerLazySingleton(() => InputConverter());
  serviceLocator.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(serviceLocator()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => sharedPreferences);
  serviceLocator.registerLazySingleton(() => Client());
  serviceLocator.registerLazySingleton(() => DataConnectionChecker());
}
