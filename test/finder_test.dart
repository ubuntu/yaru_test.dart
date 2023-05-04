import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yaru_test/yaru_test.dart';

import 'test_utils.dart';

void main() {
  testWidgets('image asset', (tester) async {
    await tester.pumpTestApp(Image.asset('assets/test.png'));
    expect(find.asset('assets/test.png'), findsOneWidget);
    expect(find.asset('assets/nothing.png'), findsNothing);
  });

  testWidgets('svg asset', (tester) async {
    await tester.pumpTestApp(SvgPicture.asset('assets/test.svg'));
    expect(find.svg('assets/test.svg'), findsOneWidget);
    expect(find.svg('assets/nothing.svg'), findsNothing);
  });

  testWidgets('html', (tester) async {
    await tester.pumpTestApp(Html(data: '<p>foo</p>'));
    expect(find.html('<p>foo</p>'), findsOneWidget);
    expect(find.html('<p>nothing</p>'), findsNothing);
  });
}
