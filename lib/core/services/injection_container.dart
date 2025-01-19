import 'package:get_it/get_it.dart';
import 'package:tdd_tutorial/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:tdd_tutorial/src/authentication/data/repositories/authentication_repository_implementation.dart';
import 'package:tdd_tutorial/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:tdd_tutorial/src/authentication/domain/usecases/create_user.dart';
import 'package:tdd_tutorial/src/authentication/domain/usecases/get_users.dart';
import 'package:tdd_tutorial/src/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:http/http.dart' as http;

final getIt = GetIt.instance;

Future<void> init() async {
  getIt
    // App Logic
    ..registerFactory(() => AuthenticationCubit(
          createUser: getIt(),
          getUsers: getIt(),
        ))

    // Use cases
    ..registerLazySingleton(() => CreateUser(getIt()))
    ..registerLazySingleton(() => GetUsers(getIt()))

    // Repositories
    ..registerLazySingleton<AuthenticationRepository>(
        () => AuthenticationRepositoryImplementation(getIt()))

    // Data Sources
    ..registerLazySingleton<AuthenticationRemoteDataSource>(
        () => AuthenticationRemoteDataSourceImpl(getIt()))

    // External Dependencies
    ..registerLazySingleton(http.Client.new);
}
