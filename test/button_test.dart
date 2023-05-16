import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yaru_test/yaru_test.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

import 'test_utils.dart';

void main() {
  testWidgets('elevated button', (tester) async {
    final testState = stateVariant.currentValue!;

    final focusNode = FocusNode();
    if (testState.hasFocus) {
      focusNode.requestFocus();
    }
    addTearDown(focusNode.dispose);

    var wasPressed = 0;

    await tester.pumpTestApp(ElevatedButton(
      focusNode: focusNode,
      onPressed: testState.isEnabled ? () => ++wasPressed : null,
      child: const Text('elevated'),
    ));
    await tester.pump();

    final button = find.button('elevated');
    expect(button, findsOneWidget);
    expect(button, testState.hasFocus ? hasFocus : hasNoFocus);
    expect(button, testState.isEnabled ? isEnabled : isDisabled);

    await tester.tapButton('elevated');
    expect(wasPressed, testState.isEnabled ? 1 : 0);
  }, variant: stateVariant);

  testWidgets('filled button', (tester) async {
    final testState = stateVariant.currentValue!;

    final focusNode = FocusNode();
    if (testState.hasFocus) {
      focusNode.requestFocus();
    }
    addTearDown(focusNode.dispose);

    var wasPressed = 0;

    await tester.pumpTestApp(FilledButton(
      focusNode: focusNode,
      onPressed: testState.isEnabled ? () => ++wasPressed : null,
      child: const Text('filled'),
    ));
    await tester.pump();

    final button = find.button('filled');
    expect(button, findsOneWidget);
    expect(button, testState.hasFocus ? hasFocus : hasNoFocus);
    expect(button, testState.isEnabled ? isEnabled : isDisabled);

    await tester.tapButton('filled');
    expect(wasPressed, testState.isEnabled ? 1 : 0);
  }, variant: stateVariant);

  testWidgets('icon button', (tester) async {
    final testState = stateVariant.currentValue!;

    final focusNode = FocusNode();
    if (testState.hasFocus) {
      focusNode.requestFocus();
    }
    addTearDown(focusNode.dispose);

    await tester.pumpTestApp(IconButton(
      focusNode: focusNode,
      onPressed: testState.isEnabled ? () {} : null,
      icon: const Icon(Icons.abc),
    ));
    await tester.pump();

    final iconButton = find.iconButton(Icons.abc);
    expect(iconButton, findsOneWidget);
    expect(iconButton, testState.hasFocus ? hasFocus : hasNoFocus);
    expect(iconButton, testState.isEnabled ? isEnabled : isDisabled);
  }, variant: stateVariant);

  testWidgets('menu item', (tester) async {
    final testState = stateVariant.currentValue!;

    final focusNode = FocusNode();
    if (testState.hasFocus) {
      focusNode.requestFocus();
    }
    addTearDown(focusNode.dispose);

    await tester.pumpTestApp(MenuItemButton(
      focusNode: focusNode,
      onPressed: testState.isEnabled ? () {} : null,
      child: const Text('menu item'),
    ));
    await tester.pump();

    final button = find.button('menu item');
    expect(button, findsOneWidget);
    expect(button, testState.hasFocus ? hasFocus : hasNoFocus);
    expect(button, testState.isEnabled ? isEnabled : isDisabled);
  }, variant: stateVariant);

  testWidgets('option button', (tester) async {
    final testState = stateVariant.currentValue!;

    final focusNode = FocusNode();
    if (testState.hasFocus) {
      focusNode.requestFocus();
    }
    addTearDown(focusNode.dispose);

    var wasPressed = 0;

    await tester.pumpTestApp(YaruOptionButton(
      focusNode: focusNode,
      onPressed: testState.isEnabled ? () => ++wasPressed : null,
      child: const Text('option'),
    ));
    await tester.pump();

    final button = find.button('option');
    expect(button, findsOneWidget);
    expect(button, testState.hasFocus ? hasFocus : hasNoFocus);
    expect(button, testState.isEnabled ? isEnabled : isDisabled);

    await tester.tapButton('option');
    expect(wasPressed, testState.isEnabled ? 1 : 0);
  }, variant: stateVariant);

  testWidgets('outlined button', (tester) async {
    final testState = stateVariant.currentValue!;

    final focusNode = FocusNode();
    if (testState.hasFocus) {
      focusNode.requestFocus();
    }
    addTearDown(focusNode.dispose);

    var wasPressed = 0;

    await tester.pumpTestApp(OutlinedButton(
      focusNode: focusNode,
      onPressed: testState.isEnabled ? () => ++wasPressed : null,
      child: const Text('outlined'),
    ));
    await tester.pump();

    final button = find.button('outlined');
    expect(button, findsOneWidget);
    expect(button, testState.hasFocus ? hasFocus : hasNoFocus);
    expect(button, testState.isEnabled ? isEnabled : isDisabled);

    await tester.tapButton('outlined');
    expect(wasPressed, testState.isEnabled ? 1 : 0);
  }, variant: stateVariant);

  testWidgets('text button', (tester) async {
    final testState = stateVariant.currentValue!;

    final focusNode = FocusNode();
    if (testState.hasFocus) {
      focusNode.requestFocus();
    }
    addTearDown(focusNode.dispose);

    var wasPressed = 0;

    await tester.pumpTestApp(TextButton(
      focusNode: focusNode,
      onPressed: testState.isEnabled ? () => ++wasPressed : null,
      child: const Text('text'),
    ));
    await tester.pump();

    final button = find.button('text');
    expect(button, findsOneWidget);
    expect(button, testState.hasFocus ? hasFocus : hasNoFocus);
    expect(button, testState.isEnabled ? isEnabled : isDisabled);

    await tester.tapButton('text');
    expect(wasPressed, testState.isEnabled ? 1 : 0);
  }, variant: stateVariant);
}
