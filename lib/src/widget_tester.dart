import 'package:flutter_test/flutter_test.dart';

import 'common_finders.dart';
import 'custom_matchers.dart';

extension YaruWidgetTester on WidgetTester {
  /// Taps a button specified by its [text].
  Future<void> tapButton(String text) => tap(find.button(text));

  /// Taps a radio specified by its [value].
  Future<void> tapRadio<T>(T value) => tap(find.radio(value));

  /// Toggles a button specified by its [text] to ensure the given [value].
  Future<void> toggleButton(String text, bool value) async {
    final finder = find.toggleButton(text);
    if (isChecked.matches(finder, {}) != value) {
      return tap(finder);
    }
  }
}
