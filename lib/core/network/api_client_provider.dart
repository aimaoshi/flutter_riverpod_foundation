import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_foundation/core/network/api_client.dart';
import 'package:flutter_riverpod_foundation/core/network/dio_provider.dart';

final apiClientProvider = Provider<ApiClient>(
  (ref) => ApiClient(ref.watch(dioProvider)),
);
