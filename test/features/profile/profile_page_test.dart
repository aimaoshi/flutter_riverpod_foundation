import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod_foundation/assets.dart';
import 'package:flutter_riverpod_foundation/features/profile/profile_page.dart';
import 'package:flutter_riverpod_foundation/shared/i18n/i18n.dart';
import 'package:flutter_riverpod_foundation/shared/i18n/locale_keys.dart';

void main() {
  testWidgets('shows the AiMaoShi profile with the generated avatar', (
    tester,
  ) async {
    await tester.pumpWidget(
      const ProviderScope(child: MaterialApp(home: ProfilePage())),
    );
    await tester.pumpAndSettle();

    final locale = Localizations.localeOf(
      tester.element(find.byType(ProfilePage)),
    );

    // 昵称在头像区和信息项中各出现一次。
    expect(find.text('AiMaoShi'), findsNWidgets(2));

    final avatar = tester.widget<Image>(find.byType(Image));
    expect((avatar.image as AssetImage).assetName, Assets.aimaoshiAvatar);

    expect(
      find.text(I18n.tr(locale, LocaleKeys.profile_nickname_label)),
      findsOneWidget,
    );
    expect(
      find.text(I18n.tr(locale, LocaleKeys.profile_gender_label)),
      findsOneWidget,
    );
    expect(
      find.text(I18n.tr(locale, LocaleKeys.profile_gender_male)),
      findsOneWidget,
    );
  });

  testWidgets('bundles the generated avatar asset', (tester) async {
    final data = await rootBundle.load(Assets.aimaoshiAvatar);

    expect(data.lengthInBytes, greaterThan(0));
  });
}
