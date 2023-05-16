import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ubuntu_localizations/ubuntu_localizations.dart';
import 'package:yaru_test/yaru_test.dart';

void main() async {
  testWidgets('ubuntu localizations', (tester) async {
    await expectLater(() => tester.ul10n.okLabel, throwsStateError);

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: UbuntuLocalizations.localizationsDelegates,
        builder: (context, child) =>
            Text(UbuntuLocalizations.of(context).okLabel),
      ),
    );

    expect(tester.ul10n.okLabel, 'OK');
    expect(find.text(tester.ul10n.okLabel), findsOneWidget);
  });

  testWidgets('app localizations', (tester) async {
    await expectLater(() => tester.al10n.testLabel, throwsStateError);

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        builder: (context, child) =>
            Text(AppLocalizations.of(context).testLabel),
      ),
    );

    expect(tester.al10n.testLabel, 'test');
    expect(find.text(tester.al10n.testLabel), findsOneWidget);
  });
}

class AppLocalizations {
  const AppLocalizations();

  static const LocalizationsDelegate<AppLocalizations> delegate =
      AppLocalizationsDelegate();

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = [
    delegate,
  ];

  static AppLocalizations of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations)!;

  String get testLabel => 'test';
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture(const AppLocalizations());
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) =>
      false;
}

extension AppLocalizationsTester on WidgetTester {
  AppLocalizations get al10n =>
      localizations<AppLocalizations>(AppLocalizations);
}
