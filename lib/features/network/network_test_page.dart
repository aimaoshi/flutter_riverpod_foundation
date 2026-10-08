import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_foundation/core/network/api_exception.dart';
import 'package:flutter_riverpod_foundation/core/network/api_response.dart';
import 'package:flutter_riverpod_foundation/core/network/network_config_provider.dart';
import 'package:flutter_riverpod_foundation/data/remote/auth/auth_remote_data_source.dart';

/// 仅用于验证网络框架，不保存账号或密码。
class NetworkTestPage extends ConsumerStatefulWidget {
  const NetworkTestPage({super.key});

  @override
  ConsumerState<NetworkTestPage> createState() => _NetworkTestPageState();
}

class _NetworkTestPageState extends ConsumerState<NetworkTestPage> {
  final _mailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String _result = '请输入测试账号后发起表单格式登录请求。';

  @override
  void dispose() {
    _mailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final mail = _mailController.text.trim();
    final password = _passwordController.text;
    if (mail.isEmpty || password.isEmpty) {
      setState(() => _result = '请输入邮箱和密码。');
      return;
    }

    setState(() => _isLoading = true);
    try {
      final ApiResponse response = await ref
          .read(authRemoteDataSourceProvider)
          .loginWithMail(mail: mail, password: password);
      if (!mounted) return;
      setState(() {
        _result = response.isSuccess
            ? '登录请求成功（resultCode: ${response.code}）'
            : '服务器返回失败（resultCode: ${response.code}）：${response.message}';
      });
    } on ApiException catch (error) {
      if (mounted) setState(() => _result = '请求失败：${error.message}');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final config = ref.watch(networkConfigProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('网络测试')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text('当前环境：${config.name}'),
            Text('服务地址：${config.baseUrl}'),
            const SizedBox(height: 24),
            TextField(
              controller: _mailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '邮箱',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '密码',
              ),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: _isLoading ? null : _login,
              child: Text(_isLoading ? '请求中…' : '测试邮箱登录（表单格式，platform: 8）'),
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(_result),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
