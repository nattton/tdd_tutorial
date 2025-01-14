import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_tutorial/src/authentication/domain/entities/user.dart';
import 'package:tdd_tutorial/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:tdd_tutorial/src/authentication/domain/usecases/get_users.dart';

import 'authentication_repository.mock.dart';

void main() {
  late GetUsers usecase;
  late AuthenticationRepository repository;

  setUpAll(() {
    repository = MockAuthenticationRepository();
    usecase = GetUsers(repository);
  });

  final users = [User.empty(), User.empty()];

  test('should call the [AuthenticationRepository.getUsers] method', () async {
    // Arrange
    // Stub
    when(() => repository.getUsers()).thenAnswer((_) async => Right(users));

    // Act
    final result = await usecase();

    // Assert
    expect(result, equals(Right(users)));

    verify(() => repository.getUsers()).called(1);
    verifyNoMoreInteractions(repository);
  });
}
