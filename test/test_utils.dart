import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yaru_test/yaru_test.dart';

class MaterialTestState {
  const MaterialTestState(this.name, this.states);

  final String name;
  final Set<MaterialState?> states;

  bool get hasFocus => states.contains(MaterialState.focused);
  bool get isChecked =>
      states.contains(MaterialState.selected) && !states.contains(null);
  bool get isEnabled => !states.contains(MaterialState.disabled);
  bool get isPartiallyChecked =>
      states.contains(MaterialState.selected) && states.contains(null);

  @override
  String toString() => name;
}

final stateVariant = ValueVariant(const {
  MaterialTestState('default', {}),
  MaterialTestState('disabled', {MaterialState.disabled}),
  MaterialTestState('focused', {MaterialState.focused}),
});

final togglableStateVariant = ValueVariant({
  ...stateVariant.values,
  const MaterialTestState('unchecked', {}),
  const MaterialTestState('checked', {MaterialState.selected}),
});

final partiallyTogglableStateVariant = ValueVariant({
  ...togglableStateVariant.values,
  const MaterialTestState('partial', {null, MaterialState.selected}),
});

extension WidgetTesterX on WidgetTester {
  Future<void> pumpTestApp(Widget widget) {
    return pumpYaruWidget(MaterialApp(home: Material(child: widget)));
  }
}
