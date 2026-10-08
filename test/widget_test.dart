import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod_foundation/app/app.dart';
import 'package:flutter_riverpod_foundation/core/storage/app_storage_provider.dart';
import 'package:flutter_riverpod_foundation/features/home/home_page.dart';
import 'package:flutter_riverpod_foundation/features/main/main_shell_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('opens the main shell home tab after startup', (tester) async {
    SharedPreferences.setMockInitialValues({
      'foundation.test.display_name': 'FlutterRiverpod',
    });
    final preferences = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [sharedPreferencesProvider.overrideWithValue(preferences)],
        child: const FlutterRiverpodFoundationApp(),
      ),
    );

    expect(find.text('Flutter Riverpod Foundation'), findsOneWidget);
    expect(find.text('正在初始化'), findsOneWidget);

    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    // 启动后直接进入主界面，并默认选中首页。
    expect(find.byType(MainShellPage), findsOneWidget);
    expect(find.byType(HomePage), findsOneWidget);
    expect(
      tester
          .widget<BottomNavigationBar>(find.byType(BottomNavigationBar))
          .currentIndex,
      0,
    );

    expect(find.text('基础框架测试页'), findsOneWidget);
    expect(find.text('你好，FlutterRiverpod'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('启动计数：1'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('启动计数：1'), findsOneWidget);
    expect(find.text('屏幕信息'), findsOneWidget);
    expect(find.textContaining('状态栏高度：'), findsOneWidget);
    expect(find.textContaining('屏幕宽度：'), findsOneWidget);
    expect(find.textContaining('屏幕高度：'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.byType(TextField),
      -300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.enterText(find.byType(TextField), 'Foundation');
    await tester.scrollUntilVisible(
      find.text('保存名称'),
      -300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('保存名称'));
    await tester.pump();

    await tester.scrollUntilVisible(
      find.text('你好，Foundation'),
      -300,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('你好，Foundation'), findsOneWidget);
  });
}
