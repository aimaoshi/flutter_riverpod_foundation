import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod_foundation/shared/i18n/i18n.dart';
import 'package:flutter_riverpod_foundation/shared/i18n/locale_keys.dart';

/// 主界面外壳：承载底部导航与四个一级页面（首页 / 设备 / 活动 / 我的）。
///
/// 通过 [StatefulNavigationShell] 与路由分支联动，切换 Tab 时保留各页面状态。
class MainShellPage extends StatelessWidget {
  const MainShellPage({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  void _onDestinationSelected(int index) {
    // 再次点击当前 Tab 时回到该分支的根页面。
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: _onDestinationSelected,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            activeIcon: const Icon(Icons.home),
            label: context.tr(LocaleKeys.tab_home),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.devices_outlined),
            activeIcon: const Icon(Icons.devices),
            label: context.tr(LocaleKeys.tab_devices),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.local_activity_outlined),
            activeIcon: const Icon(Icons.local_activity),
            label: context.tr(LocaleKeys.tab_activity),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_outline),
            activeIcon: const Icon(Icons.person),
            label: context.tr(LocaleKeys.tab_profile),
          ),
        ],
      ),
    );
  }
}
