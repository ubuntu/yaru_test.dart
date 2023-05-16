import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'common_finders.dart';
import 'custom_matchers.dart';

extension YaruWidgetTester on WidgetTester {
  /// Taps a button specified by its [text].
  Future<void> tapButton(String text) => tap(find.button(text));

  /// Taps a link with the given [label].
  Future<void> tapLink(String label) async {
    expect(find.byWidgetPredicate((widget) {
      if (widget is RichText) {
        final link = widget.findLink(label);
        if (link != null) {
          (link.recognizer as TapGestureRecognizer).onTap!();
          return true;
        }
      }
      return false;
    }), findsOneWidget);
  }

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

extension on RichText {
  TextSpan? findLink(String label) {
    TextSpan? span;
    text.visitChildren((child) {
      if (child is TextSpan &&
          child.text == label &&
          child.recognizer is TapGestureRecognizer) {
        span = child;
      }
      return span == null;
    });
    return span;
  }
}
