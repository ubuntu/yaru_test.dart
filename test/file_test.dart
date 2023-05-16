import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:yaru_test/yaru_test.dart';

void main() {
  test('matches text file', () async {
    await IOOverrides.runZoned(() async {
      await expectLater('match.txt', matchesTextFile('golden.txt'));
      await expectLater('mismatch.txt', isNot(matchesTextFile('golden.txt')));
    }, createFile: (path) {
      switch (path) {
        case 'match.txt':
          return MockFile('test');
        case 'mismatch.txt':
          return MockFile('mismatch');
        case 'golden.txt':
          return MockFile('test\n');
        default:
          throw UnsupportedError(path);
      }
    });
  });
}

class MockFile extends Mock implements File {
  MockFile(this._data);

  final String _data;

  @override
  String readAsStringSync({Encoding encoding = utf8}) => _data;
}
