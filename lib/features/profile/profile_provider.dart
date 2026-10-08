import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_foundation/assets.dart';

/// 性别。
enum ProfileGender { male, female }

/// 当前登录用户的个人资料。
@immutable
class Profile {
  const Profile({
    required this.nickname,
    required this.gender,
    required this.avatarAsset,
  });

  final String nickname;
  final ProfileGender gender;

  /// 头像资源路径。
  final String avatarAsset;
}

/// 个人资料数据来源。
///
/// 当前为本地静态数据；后续接入登录态或接口时，只需把这里换成异步
/// Provider，页面读取方式保持不变。
final profileProvider = Provider<Profile>(
  (ref) => const Profile(
    nickname: 'AiMaoShi',
    gender: ProfileGender.male,
    avatarAsset: Assets.aimaoshiAvatar,
  ),
);
