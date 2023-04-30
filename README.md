# Yaru Test

[![pub](https://img.shields.io/pub/v/yaru_test.svg)](https://pub.dev/packages/yaru_test)
[![license: MPL](https://img.shields.io/badge/license-MPL-magenta.svg)](https://opensource.org/licenses/MPL-2.0)
[![CI](https://github.com/ubuntu/yaru_test.dart/actions/workflows/ci.yaml/badge.svg)](https://github.com/ubuntu/yaru_test.dart/actions/workflows/ci.yaml)
[![codecov](https://codecov.io/gh/ubuntu/yaru_test.dart/branch/main/graph/badge.svg)](https://codecov.io/gh/ubuntu/yaru_test.dart)

Provides extensions for testing Yaru Flutter applications.

## Usage

```yaml
dev_dependencies:
  yaru_test: <version>
```

```dart
import 'package:yaru_test/yaru_test.dart';
```

### Before

```dart
final button = find.widgetWithText(OutlinedButton, ...);
expect(tester.widget<OutlinedButton>(button).enabled, isTrue);

final checkButton = find.widgetWithText(YaruCheckButton...);
expect(tester.widget<YaruCheckButton>(checkButton).value, isTrue);

final listTile = find.widgetWithText(ListTile, ...);
expect(tester.widget<ListTile>(listTile).onTap, isNull);

final textField = find.widgetWithText(TextField, ...);
expect(tester.widget<TextField>(textField).focusNode?.hasFocus, isTrue);
```

### After

```dart
expect(find.button(...), isEnabled);
expect(find.checkButton(...), isChecked);
expect(find.listTile(...), isDisabled);
expect(find.radioButton<T>(...), isChecked);
expect(find.textField(...), hasFocus);
```
