import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_foundation/core/network/api_client.dart';
import 'package:flutter_riverpod_foundation/core/network/api_client_provider.dart';
import 'package:flutter_riverpod_foundation/core/network/api_response.dart';

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>(
  (ref) => AuthRemoteDataSource(ref.watch(apiClientProvider)),
);

class AuthRemoteDataSource {
  const AuthRemoteDataSource(this._client);

  static const _mailLoginPath = '/iremote/mailuser/login';

  final ApiClient _client;

  Future<ApiResponse> loginWithMail({
    required String mail,
    required String password,
    int platform = 8,
  }) {
    return _client.postForm(
      _mailLoginPath,
      data: {'mail': mail, 'password': password, 'platform': platform},
    );
  }
}
