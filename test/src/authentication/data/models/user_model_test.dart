import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_tutorial/core/utils/typedef.dart';
import 'package:tdd_tutorial/src/authentication/data/models/user_model.dart';
import 'package:tdd_tutorial/src/authentication/domain/entities/user.dart';

import '../../../../fixtures/fixturer_reader.dart';

void main() {
  const tModel = UserModel.empty();

  test('should be a subclass of User entity', () {
    expect(tModel, isA<User>());
  });

  final tJson = FixtureReader.read('user.json');
  final tMap = jsonDecode(tJson) as DataMap;
  group('fromMap', () {
    test('should return a valid model', () {
      final result = UserModel.fromMap(tMap);
      expect(result, isA<UserModel>());
      expect(result, tModel);
    });
  });

  group('fromJson', () {
    test('should return a valid model', () {
      final result = UserModel.fromJson(tJson);
      expect(result, isA<UserModel>());
      expect(result, tModel);
    });
  });

  group('toMap', () {
    test('should return a valid map', () {
      final result = tModel.toMap();
      expect(result, tMap);
    });
  });

  group('toJson', () {
    test('should return a valid json', () {
      final result = tModel.toJson();
      expect(result, jsonEncode(jsonDecode(tJson)));
    });
  });

  group('copyWith', () {
    test('should return a valid model', () {
      final result = tModel.copyWith(id: '2');
      expect(result, isA<UserModel>());
      expect(result, tModel);
    });
  });
}
