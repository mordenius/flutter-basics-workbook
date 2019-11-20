import 'package:dartz/dartz.dart';

import './../exceptions/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
