import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

extension YaruCommonFinders on CommonFinders {
  /// Finds [Image] by [assetName].
  Finder asset(String assetName) {
    return byWidgetPredicate((w) =>
        w is Image &&
        w.image is AssetImage &&
        (w.image as AssetImage).assetName.endsWith(assetName));
  }

  /// Finds any [ButtonStyleButton] by [text].
  Finder button(String text, {bool skipOffstage = true}) {
    return ancestor(
      of: this.text(text, skipOffstage: skipOffstage),
      matching: bySubtype<ButtonStyleButton>(skipOffstage: skipOffstage),
    );
  }

  /// Finds [YaruCheckButton] by [text].
  Finder checkButton(String text, {bool skipOffstage = true}) {
    return widgetWithText(YaruCheckButton, text, skipOffstage: skipOffstage);
  }

  /// Finds [Html] by [data].
  Finder html(String data) {
    return byWidgetPredicate((w) => w is Html && w.data == data);
  }

  /// Finds any [IconButton] or [ButtonStyleButton] by [icon].
  Finder iconButton(IconData icon, {bool skipOffstage = true}) {
    return ancestor(
      of: byIcon(icon, skipOffstage: skipOffstage),
      matching: bySubtype<ButtonStyleButton>(skipOffstage: skipOffstage),
    );
  }

  /// Finds [ListTile] by [text].
  Finder listTile(String text, {bool skipOffstage = true}) {
    return widgetWithText(ListTile, text, skipOffstage: skipOffstage);
  }

  /// Finds [MenuItemButton] by [text].
  Finder menuItem(String text, {bool skipOffstage = true}) {
    return widgetWithText(MenuItemButton, text, skipOffstage: skipOffstage);
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
  Finder radioButton<T>(String text, {bool skipOffstage = true}) {
    return widgetWithText(YaruRadioButton<T>, text, skipOffstage: skipOffstage);
  }

  /// Finds [SvgPicture] by [assetName].
  Finder svg(String assetName) {
    return byWidgetPredicate((w) =>
        w is SvgPicture &&
        w.bytesLoader is SvgAssetLoader &&
        (w.bytesLoader as SvgAssetLoader).assetName.endsWith(assetName));
  }

  /// Finds [YaruSwitchButton] by [text].
  Finder switchButton(String text, {bool skipOffstage = true}) {
    return widgetWithText(YaruSwitchButton, text, skipOffstage: skipOffstage);
  }

  /// Finds [TextField] by [text] (or hint/label).
  Finder textField(String text, {bool skipOffstage = true}) {
    return widgetWithText(TextField, text, skipOffstage: skipOffstage);
  }

  /// Finds [YaruToggleButton] by [text].
  Finder toggleButton(String text, {bool skipOffstage = true}) {
    return ancestor(
      of: this.text(text, skipOffstage: skipOffstage),
      matching: bySubtype<YaruToggleButton>(skipOffstage: skipOffstage),
    );
  }
}
