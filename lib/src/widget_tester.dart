import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yaru/yaru.dart';

extension YaruWidgetTester on WidgetTester {
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
}
