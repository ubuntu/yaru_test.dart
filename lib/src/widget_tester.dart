import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'custom_matchers.dart';

extension YaruWidgetTester on WidgetTester {
  /// Toggles a [finder] to ensure the given [value].
  Future<void> toggle(Finder finder, bool value) async {
    if (isChecked.matches(finder, {}) != value) {
      return tap(finder);
    }
  }

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

  /// Pumps until the specified [finder] is satisfied. This can be used to wait
  /// until a certain page or widget becomes visible.
  Future<void> pumpUntil(
    Finder finder, [
    Duration timeout = const Duration(seconds: 10),
  ]) async {
    assert(timeout.inMilliseconds >= 250);
    const delay = Duration(milliseconds: 250);

    if (any(finder)) return;

    Future? future;
    return Future.doWhile(() async {
      if (any(finder)) return false;
      future = pump(delay);
      await future;
      return true;
    }).timeout(
      timeout,
      onTimeout: () async {
        // Ensures the `pump(delay)` future is awaited even on timeout to prevent
        // `FlutterGuardedError`s.
        await future;
        debugPrint(
            '\nWARNING: A call to pumpUntil() with finder "$finder" did not complete within the specified timeout $timeout.\n${StackTrace.current}');
      },
    );
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
