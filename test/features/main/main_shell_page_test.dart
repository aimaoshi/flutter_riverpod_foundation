import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod_foundation/app/app.dart';
import 'package:flutter_riverpod_foundation/core/storage/app_storage_provider.dart';
import 'package:flutter_riverpod_foundation/features/activity/activity_page.dart';
import 'package:flutter_riverpod_foundation/features/devices/devices_page.dart';
import 'package:flutter_riverpod_foundation/features/home/home_page.dart';
import 'package:flutter_riverpod_foundation/features/profile/profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> _pumpAppToMainShell(WidgetTester tester) async {
  SharedPreferences.setMockInitialValues({});
  final preferences = await SharedPreferences.getInstance();

  await tester.pumpWidget(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(preferences)],
      child: const KeempleFoundationApp(),
    ),
  );

  await tester.pump(const Duration(seconds: 1));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('switches between the four bottom navigation tabs', (
    tester,
  ) async {
    await _pumpAppToMainShell(tester);

    final navigationBar = find.byType(BottomNavigationBar);
    expect(tester.widget<BottomNavigationBar>(navigationBar).currentIndex, 0);
    expect(find.byType(HomePage), findsOneWidget);

    await tester.tap(find.byIcon(Icons.devices_outlined));
    await tester.pumpAndSettle();
    expect(tester.widget<BottomNavigationBar>(navigationBar).currentIndex, 1);
    expect(find.byType(DevicesPage), findsOneWidget);

    await tester.tap(find.byIcon(Icons.local_activity_outlined));
    await tester.pumpAndSettle();
    expect(tester.widget<BottomNavigationBar>(navigationBar).currentIndex, 2);
    expect(find.byType(ActivityPage), findsOneWidget);

    await tester.tap(find.byIcon(Icons.person_outline));
    await tester.pumpAndSettle();
    expect(tester.widget<BottomNavigationBar>(navigationBar).currentIndex, 3);
    expect(find.byType(ProfilePage), findsOneWidget);

    await tester.tap(find.byIcon(Icons.home_outlined));
    await tester.pumpAndSettle();
    expect(tester.widget<BottomNavigationBar>(navigationBar).currentIndex, 0);
    expect(find.byType(HomePage), findsOneWidget);
  });
}
