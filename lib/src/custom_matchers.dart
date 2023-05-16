import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
// TODO: expose YaruTogglable for testing
// ignore: implementation_imports
import 'package:yaru_widgets/src/widgets/yaru_togglable.dart';

/// Matches a focused (focusable) widget.
final hasFocus = _HasFocusMatcher(true);

/// Matches a non-focused (focusable) widget.
final hasNoFocus = _HasFocusMatcher(false);

/// Matches a checked (togglable) widget.
final isChecked = _IsCheckedMatcher(true);

/// Matches an enabled (editable, tappable, or togglable) widget.
final isEnabled = _IsEnabledMatcher(true);

/// Matches a disabled (editable, tappable, or togglable) widget.
final isDisabled = _IsEnabledMatcher(false);

/// Matches an unchecked (togglable) widget.
final isNotChecked = _IsCheckedMatcher(false);

/// Matches a partially checked (togglable) widget.
final isPartiallyChecked = _IsCheckedMatcher(null);

/// Matches a text file.
Matcher matchesTextFile(String path) => _TextFileMatcher(path);

class _IsCheckedMatcher extends CustomMatcher {
  _IsCheckedMatcher(bool? value)
      : super('Togglable widget is checked', 'checked', equals(value));

  @override
  Object? featureValueOf(covariant Finder finder) {
    final togglables = find
        .descendant(
            of: finder,
            matching: find.bySubtype<YaruTogglable>(),
            matchRoot: true)
        .evaluate()
        .map((e) => e.widget as YaruTogglable);
    return togglables.single.checked;
  }
}

class _IsEnabledMatcher extends CustomMatcher {
  _IsEnabledMatcher(bool value)
      : super('Widget is enabled', 'enabled', equals(value));

  @override
  Object featureValueOf(covariant Finder finder) {
    final editables = find
        .descendant(
            of: finder, matching: find.byType(TextField), matchRoot: true)
        .evaluate()
        .map((e) => e.widget as TextField);
    final togglables = find
        .descendant(
            of: finder,
            matching: find.bySubtype<YaruTogglable>(),
            matchRoot: true)
        .evaluate()
        .map((e) => e.widget as YaruTogglable);
    final tappables = find
        .descendant(
            of: finder,
            matching: find.bySubtype<InkResponse>(),
            matchRoot: true)
        .evaluate()
        .map((e) => e.widget as InkResponse);
    return !editables.any((e) => e.enabled == false) &&
        !togglables.any((e) => e.interactive == false) &&
        !tappables.any((e) => e.onTap == null);
  }
}

class _HasFocusMatcher extends CustomMatcher {
  _HasFocusMatcher(bool value)
      : super('Widget has focus', 'focus', equals(value));

  @override
  Object featureValueOf(covariant Finder finder) {
    final focusables = find
        .descendant(of: finder, matching: find.byType(Focus), matchRoot: true)
        .evaluate()
        .map((e) => e.widget as Focus);
    return focusables.any((f) => f.focusNode?.hasFocus == true);
  }
}

class _TextFileMatcher extends CustomMatcher {
  _TextFileMatcher(String path)
      : super('Text file matches', 'path',
            equals(File(path).readAsStringSync().trim()));

  @override
  Object featureValueOf(covariant String path) {
    return File(path).readAsStringSync().trim();
  }
}
