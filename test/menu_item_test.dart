import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yaru_test/yaru_test.dart';

import 'test_utils.dart';

void main() {
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
    ),);
    await tester.pump();

    expect(find.menuItem('menu item'), findsOneWidget);
    expect(find.menuItem(find.text('menu item')), findsOneWidget);

    final menuItem = find.menuItem('menu item');
    expect(menuItem, findsOneWidget);
    expect(menuItem, testState.hasFocus ? hasFocus : hasNoFocus);
    expect(menuItem, testState.isEnabled ? isEnabled : isDisabled);
  }, variant: stateVariant,);
}
