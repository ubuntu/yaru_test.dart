import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yaru/yaru.dart';

import 'custom_matchers.dart';

extension YaruWidgetTester on WidgetTester {
  /// Toggles a [finder] to ensure the given [value].
  Future<void> toggle(Finder finder, bool value) async {
    if (isChecked.matches(finder, {}) != value) {
      return tap(finder);
    }
  }

  /// Same as [pumpWidget] plus wraps [widget] with [YaruTheme].
  Future<void> pumpYaruWidget(
    Widget widget, {
    YaruThemeData? theme,
    Duration? duration,
    EnginePhase phase = EnginePhase.sendSemanticsUpdate,
  }) {
    return pumpWidget(
      YaruTheme(
        data: theme ?? const YaruThemeData(),
        child: widget,
      ),
      duration,
      phase,
    );
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
