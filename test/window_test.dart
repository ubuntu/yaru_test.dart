import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:yaru_test/yaru_test.dart';
import 'package:yaru_widgets/yaru_widgets.dart';
import 'package:yaru_window_platform_interface/yaru_window_platform_interface.dart';

void main() {
  testWidgets('platform window', (tester) async {
    final platform = MockYaruWindow();
    YaruWindowPlatform.instance = platform;

    const testState = YaruWindowState(
      isActive: true,
      isClosable: true,
      isFullscreen: false,
      isMaximized: false,
      isMinimized: false,
      isMovable: true,
      isRestorable: true,
      title: 'YaruTestWindow',
      isVisible: true,
    );
    when(platform.state(0)).thenAnswer((_) async => testState);

    await YaruTestWindow.ensureInitialized();
    expect(YaruWindowPlatform.instance, isA<YaruTestWindow>());

    final window = await YaruWindow.ensureInitialized();
    verify(platform.init(0)).called(1);

    await window.close();
    verifyNever(platform.close(0));

    await window.drag();
    verify(platform.drag(0)).called(1);

    await window.fullscreen();
    verify(platform.fullscreen(0)).called(1);

    await window.hide();
    verify(platform.hide(0)).called(1);

    await window.hideTitle();
    verify(platform.hideTitle(0)).called(1);

    await window.maximize();
    verify(platform.maximize(0)).called(1);

    await window.minimize();
    verify(platform.minimize(0)).called(1);

    await window.restore();
    verify(platform.restore(0)).called(1);

    await window.show();
    verify(platform.show(0)).called(1);

    await window.showMenu();
    verify(platform.showMenu(0)).called(1);

    await window.showTitle();
    verify(platform.showTitle(0)).called(1);

    await window.setBackground(Colors.red);
    verify(platform.setBackground(0, Colors.red)).called(1);

    await window.setTitle('YaruTestWindow');
    verify(platform.setTitle(0, 'YaruTestWindow')).called(1);

    await window.setMinimizable(true);
    verify(platform.setMinimizable(0, true)).called(1);

    await window.setMaximizable(true);
    verify(platform.setMaximizable(0, true)).called(1);

    await window.setClosable(true);
    verify(platform.setClosable(0, true)).called(1);

    expect(await window.state(), equals(testState));
    verify(platform.state(0)).called(1);

    await expectLater(window.states(), emits(testState));
    verify(platform.states(0)).called(1);
  });

  testWidgets('override state', (tester) async {
    final platform = MockYaruWindow();
    YaruWindowPlatform.instance = platform;

    const testState = YaruWindowState(
      isActive: true,
      isClosable: true,
      isFullscreen: false,
      isMaximized: false,
      isMinimized: false,
      isMovable: true,
      isRestorable: true,
      title: 'YaruTestWindow',
      isVisible: true,
    );

    await YaruTestWindow.ensureInitialized(state: testState);
    expect(YaruWindowPlatform.instance, isA<YaruTestWindow>());

    final window = await YaruWindow.ensureInitialized();

    expect(await window.state(), equals(testState));
    verifyNever(platform.state(0));

    await expectLater(window.states(), emits(testState));
    verifyNever(platform.states(0));
  });

  testWidgets('wait for close', (tester) async {
    final platform = MockYaruWindow();
    YaruWindowPlatform.instance = platform;

    await YaruTestWindow.ensureInitialized();
    expect(YaruWindowPlatform.instance, isA<YaruTestWindow>());

    final window = await YaruWindow.ensureInitialized();

    var onClose = 0;
    await window.onClose(() => ++onClose > 0);

    final waitForClosed = YaruTestWindow.waitForClosed();

    await window.close();
    verifyNever(platform.close(any));
    expect(onClose, equals(1));

    await expectLater(waitForClosed, completes);
  });
}

class MockYaruWindow extends Mock
    with MockPlatformInterfaceMixin
    implements YaruWindowPlatform {
  @override
  Future<void> init(int? id) {
    return super.noSuchMethod(
      Invocation.method(#init, [id]),
      returnValue: Future.value(),
      returnValueForMissingStub: Future.value(),
    );
  }

  @override
  Future<void> close(int? id) {
    return super.noSuchMethod(
      Invocation.method(#close, [id]),
      returnValue: Future.value(),
      returnValueForMissingStub: Future.value(),
    );
  }

  @override
  Future<void> drag(int? id) {
    return super.noSuchMethod(
      Invocation.method(#drag, [id]),
      returnValue: Future.value(),
      returnValueForMissingStub: Future.value(),
    );
  }

  @override
  Future<void> fullscreen(int? id) {
    return super.noSuchMethod(
      Invocation.method(#fullscreen, [id]),
      returnValue: Future.value(),
      returnValueForMissingStub: Future.value(),
    );
  }

  @override
  Future<void> hide(int? id) {
    return super.noSuchMethod(
      Invocation.method(#hide, [id]),
      returnValue: Future.value(),
      returnValueForMissingStub: Future.value(),
    );
  }

  @override
  Future<void> hideTitle(int? id) {
    return super.noSuchMethod(
      Invocation.method(#hideTitle, [id]),
      returnValue: Future.value(),
      returnValueForMissingStub: Future.value(),
    );
  }

  @override
  Future<void> maximize(int? id) {
    return super.noSuchMethod(
      Invocation.method(#maximize, [id]),
      returnValue: Future.value(),
      returnValueForMissingStub: Future.value(),
    );
  }

  @override
  Future<void> minimize(int? id) {
    return super.noSuchMethod(
      Invocation.method(#minimize, [id]),
      returnValue: Future.value(),
      returnValueForMissingStub: Future.value(),
    );
  }

  @override
  Future<void> restore(int? id) {
    return super.noSuchMethod(
      Invocation.method(#restore, [id]),
      returnValue: Future.value(),
      returnValueForMissingStub: Future.value(),
    );
  }

  @override
  Future<void> show(int? id) {
    return super.noSuchMethod(
      Invocation.method(#show, [id]),
      returnValue: Future.value(),
      returnValueForMissingStub: Future.value(),
    );
  }

  @override
  Future<void> showMenu(int? id) {
    return super.noSuchMethod(
      Invocation.method(#showMenu, [id]),
      returnValue: Future.value(),
      returnValueForMissingStub: Future.value(),
    );
  }

  @override
  Future<void> showTitle(int? id) {
    return super.noSuchMethod(
      Invocation.method(#showTitle, [id]),
      returnValue: Future.value(),
      returnValueForMissingStub: Future.value(),
    );
  }

  @override
  Future<void> setBackground(int? id, Color color) {
    return super.noSuchMethod(
      Invocation.method(#setBackground, [id, color]),
      returnValue: Future.value(),
      returnValueForMissingStub: Future.value(),
    );
  }

  @override
  Future<void> setTitle(int? id, String title) {
    return super.noSuchMethod(
      Invocation.method(#setTitle, [id, title]),
      returnValue: Future.value(),
      returnValueForMissingStub: Future.value(),
    );
  }

  @override
  Future<void> setMinimizable(int? id, bool minimizable) {
    return super.noSuchMethod(
      Invocation.method(#setMinimizable, [id, minimizable]),
      returnValue: Future.value(),
      returnValueForMissingStub: Future.value(),
    );
  }

  @override
  Future<void> setMaximizable(int? id, bool maximizable) {
    return super.noSuchMethod(
      Invocation.method(#setMaximizable, [id, maximizable]),
      returnValue: Future.value(),
      returnValueForMissingStub: Future.value(),
    );
  }

  @override
  Future<void> setClosable(int? id, bool closable) {
    return super.noSuchMethod(
      Invocation.method(#setClosable, [id, closable]),
      returnValue: Future.value(),
      returnValueForMissingStub: Future.value(),
    );
  }

  @override
  Future<YaruWindowState> state(int? id) {
    return super.noSuchMethod(
      Invocation.method(#state, [id]),
      returnValue: Future.value(const YaruWindowState()),
      returnValueForMissingStub: Future.value(const YaruWindowState()),
    );
  }

  @override
  Stream<YaruWindowState> states(int? id) {
    return super.noSuchMethod(
      Invocation.method(#states, [id]),
      returnValue: Stream.value(const YaruWindowState()),
      returnValueForMissingStub: Stream.value(const YaruWindowState()),
    );
  }
}
