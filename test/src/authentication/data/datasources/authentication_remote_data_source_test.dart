import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:tdd_tutorial/core/errors/exceptions.dart';
import 'package:tdd_tutorial/core/utils/constants.dart';
import 'package:tdd_tutorial/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:tdd_tutorial/src/authentication/data/models/user_model.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late AuthenticationRemoteDataSource remoteDataSource;

  setUpAll(() {
    client = MockClient();
    remoteDataSource = AuthenticationRemoteDataSourceImpl(client);
    registerFallbackValue(Uri());
  });

  group('createUser', () {
    test(
      'should complete successfully when the status code is 200 or 201',
      () async {
        when(
          () => client.post(any(), body: any(named: 'body')),
        ).thenAnswer(
          (_) async => http.Response('User created successfully', 201),
        );

        final methodCall = remoteDataSource.createUser(
          createdAt: 'createdAt',
          name: 'name',
          avatar: 'avatar',
        );

        expect(methodCall, completes);

        verify(
          () => client.post(
            Uri.parse('$kBaseUrl$kCreateUserEndpoint'),
            body: jsonEncode({
              'createdAt': 'createdAt',
              'name': 'name',
              'avatar': 'avatar',
            }),
          ),
        ).called(1);

        verifyNoMoreInteractions(client);
      },
    );

    test(
      'should throw [APIException] when the status code is not 200 or '
      '201',
      () async {
        when(() => client.post(any(), body: any(named: 'body'))).thenAnswer(
          (_) async => http.Response('Invalid email address', 400),
        );
        final methodCall = remoteDataSource.createUser(
          createdAt: 'createdAt',
          name: 'name',
          avatar: 'avatar',
        );

        expect(
            () async => methodCall,
            throwsA(const ApiException(
                message: 'Invalid email address', statusCode: 400)));

        verify(
          () => client.post(
            Uri.parse('$kBaseUrl$kCreateUserEndpoint'),
            body: jsonEncode({
              'createdAt': 'createdAt',
              'name': 'name',
              'avatar': 'avatar',
            }),
          ),
        ).called(1);

        verifyNoMoreInteractions(client);
      },
    );
  });

  group('getUsers', () {
    final tUsers = [UserModel.empty()];
    test(
      'should complete successfully when the status code is 200 or 201',
      () async {
        when(() => client.get(any())).thenAnswer(
          (_) async => http.Response(jsonEncode([tUsers.first.toMap()]), 201),
        );

        final result = await remoteDataSource.getUsers();
        expect(result, tUsers);

        verify(() => client.get(Uri.parse('$kBaseUrl$kGetUserEndpoint')))
            .called(1);
        verifyNoMoreInteractions(client);
      },
    );

    test(
      'should throw [ApiException] when the status code is not 200',
      () async {
        const tMessage = 'Server down';
        const tStatusCode = 500;
        when(() => client.get(any())).thenAnswer(
          (_) async => http.Response(jsonEncode(tMessage), tStatusCode),
        );

        final methodCall = remoteDataSource.getUsers();

        expect(
          () => methodCall,
          throwsA(
            const ApiException(message: tMessage, statusCode: tStatusCode),
          ),
        );

        verify(() => client.get(Uri.parse('$kBaseUrl$kGetUserEndpoint')))
            .called(1);
        verifyNoMoreInteractions(client);
      },
    );
  });
}
