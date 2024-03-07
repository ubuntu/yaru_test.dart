import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yaru/widgets.dart';
import 'package:yaru_test/yaru_test.dart';

import 'test_utils.dart';

void main() {
  testWidgets('find title bar', (tester) async {
    await tester.pumpTestApp(YaruTitleBar(
      title: const Text('title bar'),
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {},
        ),
      ],
    ));

    expect(find.titleBar('title bar'), findsOneWidget);
    expect(find.titleBar(find.text('title bar')), findsOneWidget);
    expect(find.titleBar(find.byIcon(Icons.add)), findsOneWidget);
  });
}
