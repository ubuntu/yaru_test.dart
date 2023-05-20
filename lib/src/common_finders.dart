import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

/// Convenient high-level common finder extensions for buttons and alike.
extension YaruCommonFinders on CommonFinders {
  /// Finds any [ButtonStyleButton] by [text].
  Finder button(dynamic text, {bool skipOffstage = true}) {
    return ancestor(
      of: _textOrFinder(text, skipOffstage),
      matching: bySubtype<ButtonStyleButton>(skipOffstage: skipOffstage),
    );
  }

  /// Finds [YaruCheckButton] by [text].
  Finder checkButton(dynamic text, {bool skipOffstage = true}) {
    return ancestor(
      of: _textOrFinder(text, skipOffstage),
      matching: byType(YaruCheckButton, skipOffstage: skipOffstage),
    );
  }

  /// Finds [ButtonStyleButton] by [icon].
  Finder iconButton(IconData icon, {bool skipOffstage = true}) {
    return ancestor(
      of: byIcon(icon, skipOffstage: skipOffstage),
      matching: bySubtype<ButtonStyleButton>(skipOffstage: skipOffstage),
    );
  }

  /// Finds [ListTile] by [text].
  Finder listTile(dynamic text, {bool skipOffstage = true}) {
    return ancestor(
      of: _textOrFinder(text, skipOffstage),
      matching: byType(ListTile, skipOffstage: skipOffstage),
    );
  }

  /// Finds [MenuItemButton] by [text].
  Finder menuItem(dynamic text, {bool skipOffstage = true}) {
    return ancestor(
      of: _textOrFinder(text, skipOffstage),
      matching: byType(MenuItemButton, skipOffstage: skipOffstage),
    );
  }

  /// Finds [Radio] or [YaruRadio] by [value].
  Finder radio<T>(T value, {bool skipOffstage = true}) {
    return byWidgetPredicate(
      (w) =>
          (w is Radio<T> && w.value == value) ||
          (w is YaruRadio<T> && w.value == value),
      skipOffstage: skipOffstage,
    );
  }

  /// Finds [YaruRadioButton] by [text].
  Finder radioButton<T>(dynamic text, {bool skipOffstage = true}) {
    return ancestor(
      of: _textOrFinder(text, skipOffstage),
      matching: byType(YaruRadioButton<T>, skipOffstage: skipOffstage),
    );
  }

  /// Finds [YaruSwitchButton] by [text].
  Finder switchButton(dynamic text, {bool skipOffstage = true}) {
    return ancestor(
      of: _textOrFinder(text, skipOffstage),
      matching: byType(YaruSwitchButton, skipOffstage: skipOffstage),
    );
  }

  /// Finds [TextField] by [text] (or hint/label).
  Finder textField(dynamic text, {bool skipOffstage = true}) {
    return ancestor(
      of: _textOrFinder(text, skipOffstage),
      matching: byType(TextField, skipOffstage: skipOffstage),
    );
  }

  /// Finds [YaruToggleButton] by [text].
  Finder toggleButton(dynamic text, {bool skipOffstage = true}) {
    return ancestor(
      of: _textOrFinder(text, skipOffstage),
      matching: bySubtype<YaruToggleButton>(skipOffstage: skipOffstage),
    );
  }

  Finder _textOrFinder(dynamic text, bool skipOffstage) {
    return text is String
        ? find.text(text, skipOffstage: skipOffstage)
        : text as Finder;
  }
}
