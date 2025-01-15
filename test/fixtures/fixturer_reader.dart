import 'dart:io';

class FixtureReader {
  static String read(String name) =>
      File('test/fixtures/$name').readAsStringSync();
}
