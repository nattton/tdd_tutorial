import 'package:tdd_tutorial/core/utils/typedef.dart';

abstract class UseCaseWithParams<T, Params> {
  const UseCaseWithParams();

  ResultFuture<T> call(Params params);
}

abstract class UseCaseWithNoParam<T> {
  const UseCaseWithNoParam();

  ResultFuture<T> call();
}
