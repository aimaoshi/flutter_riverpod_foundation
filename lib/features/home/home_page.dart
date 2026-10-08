import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod_foundation/app/router/app_router.dart';
import 'package:flutter_riverpod_foundation/core/storage/app_storage_provider.dart';
import 'package:flutter_riverpod_foundation/shared/i18n/i18n.dart';
import 'package:flutter_riverpod_foundation/shared/i18n/locale_controller.dart';
import 'package:flutter_riverpod_foundation/shared/i18n/locale_keys.dart';
import 'package:flutter_riverpod_foundation/shared/ui/layout/app_layout.dart';

/// 首页 Tab：承载基础框架测试内容（启动、路由、Riverpod、存储、国际化）。
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  static const _launchCountKey = 'foundation.test.launch_count';
  static const _payloadKey = 'foundation.test.payload';
  static const _displayNameKey = 'foundation.test.display_name';

  int _launchCount = 0;
  final _nameController = TextEditingController();
  String _displayName = '';
  String _status = 'AppStorage 已就绪';

  @override
  void initState() {
    super.initState();
    _loadInitialState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _loadInitialState() async {
    final storage = ref.read(appStorageProvider);
    final savedName = storage.getString(_displayNameKey);
    final nextCount = storage.getInt(_launchCountKey) + 1;
    await storage.setInt(_launchCountKey, nextCount);

    if (mounted) {
      setState(() {
        _displayName = savedName;
        _nameController.text = savedName;
        _launchCount = nextCount;
      });
    }
  }

  Future<void> _saveDisplayName() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      setState(() => _status = '请输入名称后再保存');
      return;
    }

    await ref.read(appStorageProvider).setString(_displayNameKey, name);
    if (mounted) {
      setState(() {
        _displayName = name;
        _status = '名称已保存，下次启动会自动显示';
      });
    }
  }

  Future<void> _saveTestPayload() async {
    await ref.read(appStorageProvider).setJson(_payloadKey, {
      'savedAt': DateTime.now().toIso8601String(),
    });

    if (mounted) {
      setState(() => _status = '测试数据已写入 AppStorage');
    }
  }

  static const _localeOptions = <(String, Locale?)>[
    ('跟随系统', null),
    ('简体中文', Locale('zh', 'CN')),
    (
      '繁體（台灣）',
      Locale.fromSubtags(
        languageCode: 'zh',
        scriptCode: 'Hant',
        countryCode: 'TW',
      ),
    ),
    ('English', Locale('en')),
    ('Français', Locale('fr')),
    ('עברית', Locale('he')),
    ('日本語', Locale('ja')),
    ('Polski', Locale('pl')),
    ('Tiếng Việt', Locale('vi')),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final layout = context.layout;
    final localeController = ref.read(localeControllerProvider.notifier);
    final selectedLocale = ref.watch(localeControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Keemple Foundation')),
      body: SafeArea(
        child: Padding(
          padding: layout.pagePadding,
          child: ListView(
            children: [
              Text('基础框架测试页', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 8),
              Text(
                '用于验证启动、路由、Riverpod、本地存储和国际化。',
                style: Theme.of(context).textTheme.bodyMedium
                    ?.copyWith(color: colorScheme.onSurfaceVariant),
              ),
              const SizedBox(height: 24),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('国际化 Demo'),
                      const SizedBox(height: 8),
                      Text(
                        context.tr(LocaleKeys.i_am_a_demo),
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      InputDecorator(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: '语言',
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<Locale?>(
                            isExpanded: true,
                            value: selectedLocale,
                            items: [
                              for (final option in _localeOptions)
                                DropdownMenuItem(
                                  value: option.$2,
                                  child: Text(option.$1),
                                ),
                            ],
                            onChanged: (locale) {
                              if (locale == null) {
                                localeController.followSystem();
                              } else {
                                localeController.setLocale(locale);
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                _displayName.isEmpty ? '尚未设置名称' : '你好，$_displayName',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _nameController,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '名称',
                  hintText: '请输入名称',
                ),
                onSubmitted: (_) => _saveDisplayName(),
              ),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: _saveDisplayName,
                child: const Text('保存名称'),
              ),
              const SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('屏幕信息'),
                      const SizedBox(height: 8),
                      Text(
                        '状态栏高度：${layout.getAppBarHeight().toStringAsFixed(1)}',
                      ),
                      Text(
                        '屏幕宽度：${layout.getScreenWidth().toStringAsFixed(1)}',
                      ),
                      Text(
                        '屏幕高度：${layout.getScreenHeight().toStringAsFixed(1)}',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('当前状态'),
                      const SizedBox(height: 8),
                      Text(_status),
                      const SizedBox(height: 16),
                      Text('启动计数：$_launchCount'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              FilledButton.icon(
                onPressed: _saveTestPayload,
                icon: const Icon(Icons.save_outlined),
                label: const Text('写入测试数据'),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () => context.push(AppRoutes.networkTest),
                icon: const Icon(Icons.http_outlined),
                label: const Text('打开网络测试'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
