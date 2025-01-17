import 'package:fpdart/fpdart.dart';
import 'package:tdd_tutorial/core/errors/exceptions.dart';
import 'package:tdd_tutorial/core/errors/failure.dart';
import 'package:tdd_tutorial/core/utils/typedef.dart';
import 'package:tdd_tutorial/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:tdd_tutorial/src/authentication/domain/entities/user.dart';
import 'package:tdd_tutorial/src/authentication/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImplementation
    implements AuthenticationRepository {
  const AuthenticationRepositoryImplementation(this._remoteDataSource);

  final AuthenticationRemoteDataSource _remoteDataSource;

  @override
  ResultVoid createUser(
      {required String createdAt,
      required String name,
      required String avatar}) async {
    // Test-Driven Development
    // call the remote data source
    // make sure that it returns the proper data if there is no exception
    // // check if when the remoteDataSource throws an exception, we return a
    // failure
    try {
      await _remoteDataSource.createUser(
          createdAt: createdAt, name: name, avatar: avatar);
      return const Right(null);
    } on ApiException catch (e) {
      return Left(ApiFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<List<User>> getUsers() async {
    throw UnimplementedError();
  }
}
