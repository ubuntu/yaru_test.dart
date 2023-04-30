import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yaru_test/yaru_test.dart';

import 'test_utils.dart';

void main() {
  testWidgets('list tile', (tester) async {
    final testState = stateVariant.currentValue!;

    final focusNode = FocusNode();
    if (testState.hasFocus) {
      focusNode.requestFocus();
    }
    addTearDown(focusNode.dispose);

    await tester.pumpTestApp(ListTile(
      focusNode: focusNode,
      onTap: testState.isEnabled ? () {} : null,
      title: const Text('list tile'),
    ));
    await tester.pump();

    final listTile = find.listTile('list tile');
    expect(listTile, findsOneWidget);
    expect(listTile, testState.hasFocus ? hasFocus : hasNoFocus);
    expect(listTile, testState.isEnabled ? isEnabled : isDisabled);
  }, variant: stateVariant);
}
