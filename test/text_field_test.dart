import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yaru_test/yaru_test.dart';

import 'test_utils.dart';

void main() {
  testWidgets('find text field', (tester) async {
    await tester.pumpTestApp(TextFormField(
      initialValue: 'text field',
      decoration: const InputDecoration(
        hintText: 'hint text',
        labelText: 'label text',
      ),
    ));

    expect(find.textField('text field'), findsOneWidget);
    expect(find.textField('hint text'), findsOneWidget);
    expect(find.textField('label text'), findsOneWidget);
    expect(find.textField('nothing'), findsNothing);
    expect(find.textField(find.textContaining('text')), findsNWidgets(3));
  });

  testWidgets('match text field', (tester) async {
    final testState = stateVariant.currentValue!;

    final controller = TextEditingController(text: 'text field');
    addTearDown(controller.dispose);

    await tester.pumpTestApp(TextFormField(
      autofocus: testState.hasFocus,
      enabled: testState.isEnabled,
      initialValue: 'text field',
    ));
    await tester.pump();

    final textField = find.textField('text field');
    expect(textField, testState.hasFocus ? hasFocus : hasNoFocus);
    expect(textField, testState.isEnabled ? isEnabled : isDisabled);
  }, variant: stateVariant);
}
