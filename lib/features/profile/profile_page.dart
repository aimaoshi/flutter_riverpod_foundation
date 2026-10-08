import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_foundation/features/profile/profile_provider.dart';
import 'package:flutter_riverpod_foundation/shared/i18n/i18n.dart';
import 'package:flutter_riverpod_foundation/shared/i18n/locale_keys.dart';
import 'package:flutter_riverpod_foundation/shared/ui/layout/app_layout.dart';

/// 我的 Tab：展示当前用户的个人信息。
class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(context.tr(LocaleKeys.tab_profile))),
      body: SafeArea(
        child: ListView(
          padding: context.layout.pagePadding,
          children: [
            _ProfileHeader(profile: profile),
            const SizedBox(height: 24),
            Text(
              context.tr(LocaleKeys.profile_title),
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Card(
              child: Column(
                children: [
                  _InfoTile(
                    label: context.tr(LocaleKeys.profile_nickname_label),
                    value: profile.nickname,
                  ),
                  const Divider(height: 1, indent: 16, endIndent: 16),
                  _InfoTile(
                    label: context.tr(LocaleKeys.profile_gender_label),
                    value: _genderLabel(context, profile.gender),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _genderLabel(BuildContext context, ProfileGender gender) {
    return switch (gender) {
      ProfileGender.male => context.tr(LocaleKeys.profile_gender_male),
      ProfileGender.female => context.tr(LocaleKeys.profile_gender_female),
    };
  }
}

/// 头像 + 昵称。
class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.profile});

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            ClipOval(
              child: Image.asset(
                profile.avatarAsset,
                width: 72,
                height: 72,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 72,
                  height: 72,
                  color: colorScheme.primaryContainer,
                  child: Icon(
                    Icons.person,
                    color: colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                profile.nickname,
                style: theme.textTheme.titleLarge,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 一行"标签 — 值"信息。
class _InfoTile extends StatelessWidget {
  const _InfoTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const Spacer(),
          Text(value, style: theme.textTheme.bodyLarge),
        ],
      ),
    );
  }
}
