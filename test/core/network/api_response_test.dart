import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod_foundation/core/network/api_response.dart';

void main() {
  test('keeps root fields as data for a direct login response', () {
    final response = ApiResponse.fromJson({
      'resultCode': 0,
      'alias': 'example-alias',
      'timezoneid': 'Europe/Warsaw',
    });

    expect(response.isSuccess, isTrue);
    expect(response.data, isA<Map<String, Object?>>());
    expect(
      (response.data! as Map<String, Object?>)['timezoneid'],
      'Europe/Warsaw',
    );
  });

  test('decodes the data field from a legacy response envelope', () {
    final response = ApiResponse.fromJson({
      'resultCode': 0,
      'data': '{"name":"FlutterRiverpod"}',
    });

    expect(response.data, {'name': 'FlutterRiverpod'});
  });
}
