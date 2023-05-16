import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ubuntu_localizations/ubuntu_localizations.dart';

import 'common_finders.dart';
import 'custom_matchers.dart';

final _localizations = <Type, Object>{};

extension YaruWidgetTester on WidgetTester {
  /// The [UbuntuLocalizations] instance.
  UbuntuLocalizations get ul10n =>
      localizations<UbuntuLocalizations>(UbuntuLocalizations);

  T localizations<T>(Type type) {
    if (_localizations.containsKey(T)) return _localizations[T] as T;

    final result = find.byWidgetPredicate((widget) {
      final context = element(find.byWidget(widget));
      return Localizations.of<T>(context, type) != null;
    });

    if (result.evaluate().isEmpty) {
      throw StateError('''
No $T found in the widget tree.

Pump a widget tree with `LocalizationsDelegate<$T>` before calling
`YaruWidgetTester.findLocalizations<$T>()`. For example:

  await tester.pumpWidget(
    MaterialApp(
      localizationsDelegates: $T.localizationsDelegates,
      home: ...
    ),
  );

  final l10n = tester.localizations<$T>();
  expect(find.text(l10n.fooLabel), findsOneWidget);
''');
    }

    final l10n = Localizations.of(element(result.first), T)!;
    _localizations[T] = l10n;
    if (_localizations.length == 1) addTearDown(_localizations.clear);
    return l10n;
  }

  /// Taps a button specified by its [text].
  Future<void> tapButton(String text) => tap(find.button(text));

  /// Taps a _Back_ button.
  Future<void> tapBack() => tapButton(ul10n.backLabel);

  /// Taps a _Cancel_ button.
  Future<void> tapCancel() => tapButton(ul10n.cancelLabel);

  /// Taps a _Close_ button.
  Future<void> tapClose() => tapButton(ul10n.closeLabel);

  /// Taps a _Continue_ button.
  Future<void> tapContinue() => tapButton(ul10n.continueLabel);

  /// Taps a _Next_ button.
  Future<void> tapNext() => tapButton(ul10n.nextLabel);

  /// Taps an _Ok_ button.
  Future<void> tapOk() => tapButton(ul10n.okLabel);

  /// Taps a _Previous_ button.
  Future<void> tapPrevious() => tapButton(ul10n.previousLabel);

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
