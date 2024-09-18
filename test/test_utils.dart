import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yaru/yaru.dart';

class MaterialTestState {
  const MaterialTestState(this.name, this.states);

  final String name;
  final Set<WidgetState?> states;

  bool get hasFocus => states.contains(WidgetState.focused);
  bool get isChecked =>
      states.contains(WidgetState.selected) && !states.contains(null);
  bool get isEnabled => !states.contains(WidgetState.disabled);
  bool get isPartiallyChecked =>
      states.contains(WidgetState.selected) && states.contains(null);

  @override
  String toString() => name;
}

final stateVariant = ValueVariant(const {
  MaterialTestState('default', {}),
  MaterialTestState('disabled', {WidgetState.disabled}),
  MaterialTestState('focused', {WidgetState.focused}),
});

final togglableStateVariant = ValueVariant({
  ...stateVariant.values,
  const MaterialTestState('unchecked', {}),
  const MaterialTestState('checked', {WidgetState.selected}),
});

final partiallyTogglableStateVariant = ValueVariant({
  ...togglableStateVariant.values,
  const MaterialTestState('partial', {null, WidgetState.selected}),
});

extension WidgetTesterX on WidgetTester {
  Future<void> pumpTestApp(Widget widget) {
    return pumpWidget(MaterialApp(
      theme: yaruLight,
      home: Material(child: widget),
    ),);
  }
}
