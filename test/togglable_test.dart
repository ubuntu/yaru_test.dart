import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yaru_test/yaru_test.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

import 'test_utils.dart';

void main() {
  testWidgets('check button', (tester) async {
    final testState = partiallyTogglableStateVariant.currentValue!;

    final focusNode = FocusNode();
    if (testState.hasFocus) {
      focusNode.requestFocus();
    }
    addTearDown(focusNode.dispose);

    await tester.pumpTestApp(YaruCheckButton(
      focusNode: focusNode,
      value: testState.isChecked
          ? true
          : testState.isPartiallyChecked
              ? null
              : false,
      tristate: testState.isPartiallyChecked,
      onChanged: testState.isEnabled ? (value) {} : null,
      title: const Text('check button'),
    ));
    await tester.pump();

    final checkButton = find.checkButton('check button');
    expect(checkButton, findsOneWidget);
    expect(checkButton, testState.hasFocus ? hasFocus : hasNoFocus);
    expect(checkButton, testState.isEnabled ? isEnabled : isDisabled);
    expect(
        checkButton,
        testState.isChecked
            ? isChecked
            : testState.isPartiallyChecked
                ? isPartiallyChecked
                : isNotChecked);
  }, variant: partiallyTogglableStateVariant);

  testWidgets('radio button', (tester) async {
    final testState = togglableStateVariant.currentValue!;

    final focusNode = FocusNode();
    if (testState.hasFocus) {
      focusNode.requestFocus();
    }
    addTearDown(focusNode.dispose);

    final value = testState.isChecked ? Brightness.light : Brightness.dark;

    await tester.pumpTestApp(YaruRadioButton<Brightness>(
      focusNode: focusNode,
      value: value,
      groupValue: Brightness.light,
      onChanged: testState.isEnabled ? (value) {} : null,
      title: const Text('radio button'),
    ));
    await tester.pump();

    final radio = find.radio<Brightness>(value);
    expect(radio, findsOneWidget);

    final radioButton = find.radioButton<Brightness>('radio button');
    expect(radioButton, findsOneWidget);
    expect(radioButton, testState.hasFocus ? hasFocus : hasNoFocus);
    expect(radioButton, testState.isChecked ? isChecked : isNotChecked);
    expect(radioButton, testState.isEnabled ? isEnabled : isDisabled);
  }, variant: togglableStateVariant);

  testWidgets('switch button', (tester) async {
    final testState = togglableStateVariant.currentValue!;

    final focusNode = FocusNode();
    if (testState.hasFocus) {
      focusNode.requestFocus();
    }
    addTearDown(focusNode.dispose);

    await tester.pumpTestApp(YaruSwitchButton(
      focusNode: focusNode,
      value: testState.isChecked,
      onChanged: testState.isEnabled ? (value) {} : null,
      title: const Text('switch button'),
    ));
    await tester.pump();

    final switchButton = find.switchButton('switch button');
    expect(switchButton, findsOneWidget);
    expect(switchButton, testState.hasFocus ? hasFocus : hasNoFocus);
    expect(switchButton, testState.isChecked ? isChecked : isNotChecked);
    expect(switchButton, testState.isEnabled ? isEnabled : isDisabled);
  }, variant: togglableStateVariant);

  testWidgets('toggle', (tester) async {
    final values = [false, false, false];

    await tester.pumpTestApp(StatefulBuilder(builder: (context, setState) {
      return Column(
        children: [
          YaruCheckButton(
            value: values[0],
            onChanged: (v) => setState(() => values[0] = v!),
            title: const Text('check button'),
          ),
          YaruRadioButton<bool>(
            value: values[1],
            groupValue: true,
            onChanged: (v) => setState(() => values[1] = !v!),
            title: const Text('radio button'),
          ),
          YaruSwitchButton(
            value: values[2],
            onChanged: (v) => setState(() => values[2] = v),
            title: const Text('switch button'),
          ),
        ],
      );
    }));
    await tester.pump();

    final checkButton = find.checkButton('check button');
    expect(checkButton, isNotChecked);

    await tester.toggle(checkButton, true);
    await tester.pump();
    expect(checkButton, isChecked);

    final radioButton = find.radioButton<bool>('radio button');
    expect(radioButton, isNotChecked);

    await tester.toggle(radioButton, true);
    await tester.pump();
    expect(radioButton, isChecked);

    final switchButton = find.switchButton('switch button');
    expect(switchButton, isNotChecked);

    await tester.toggle(switchButton, true);
    await tester.pump();
    expect(switchButton, isChecked);
  });
}
