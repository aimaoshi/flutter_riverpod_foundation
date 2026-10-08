import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod_foundation/shared/ui/layout/app_layout.dart';

void main() {
  testWidgets('reads the current media query layout metrics', (tester) async {
    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(
          size: Size(800, 600),
          padding: EdgeInsets.only(top: 24, bottom: 16),
          viewInsets: EdgeInsets.only(bottom: 200),
        ),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Builder(
            builder: (context) {
              final layout = context.layout;
              return Text(
                '${layout.getScreenWidth()}-${layout.getAppBarHeight()}-${layout.getStatusBarHeight()}-${layout.getHeight(48)}',
              );
            },
          ),
        ),
      ),
    );

    expect(find.text('800.0-24.0-16.0-48.0'), findsOneWidget);
  });
}
