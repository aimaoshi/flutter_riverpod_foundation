import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod_foundation/features/activity/activity_page.dart';
import 'package:flutter_riverpod_foundation/features/devices/devices_page.dart';
import 'package:flutter_riverpod_foundation/features/home/home_page.dart';
import 'package:flutter_riverpod_foundation/features/main/main_shell_page.dart';
import 'package:flutter_riverpod_foundation/features/network/network_test_page.dart';
import 'package:flutter_riverpod_foundation/features/profile/profile_page.dart';
import 'package:flutter_riverpod_foundation/features/splash/splash_page.dart';

abstract final class AppRoutes {
  static const splash = '/';
  static const home = '/home';
  static const devices = '/devices';
  static const activity = '/activity';
  static const profile = '/profile';
  static const networkTest = '/network-test';
}

final appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const SplashPage(),
    ),
    // 主界面：底部导航承载四个一级页面，切换 Tab 时保留各自的状态与导航栈。
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          MainShellPage(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.home,
              builder: (context, state) => const HomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.devices,
              builder: (context, state) => const DevicesPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.activity,
              builder: (context, state) => const ActivityPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.profile,
              builder: (context, state) => const ProfilePage(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: AppRoutes.networkTest,
      builder: (context, state) => const NetworkTestPage(),
    ),
  ],
);
