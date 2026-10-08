import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod_foundation/core/storage/app_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late AppStorage storage;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    storage = AppStorage(await SharedPreferences.getInstance());
  });

  test('stores and decodes JSON values', () async {
    await storage.setJson('profile', {'name': 'Keemple'});

    final profile = storage.getJson<Map<String, dynamic>>(
      'profile',
      (json) => Map<String, dynamic>.from(json! as Map),
    );

    expect(profile, {'name': 'Keemple'});
  });

  test('removes all keys that share a prefix', () async {
    await storage.setString('session.token', 'token');
    await storage.setString('session.account', 'account');
    await storage.setString('settings.language', 'zh');

    await storage.removeByPrefix('session.');

    expect(storage.containsKey('session.token'), isFalse);
    expect(storage.containsKey('session.account'), isFalse);
    expect(storage.getString('settings.language'), 'zh');
  });
}
