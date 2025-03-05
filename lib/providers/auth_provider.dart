// lib/providers/auth_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../services/local_storage_service.dart';

part 'auth_provider.g.dart';

@riverpod
class AuthState extends _$AuthState {
  @override
  FutureOr<bool> build() {
    // 确保存储服务已初始化
    final storage = ref.watch(localStorageServiceProvider);
    return storage.when(
      data: (prefs) => prefs.getKeys().contains('authToken'),
      loading: () => false,
      error: (_, __) => false,
    );
  }

  Future<void> login(String token) async {
    final storage = await ref.read(localStorageServiceProvider.future);
    await storage.setString('authToken', token);
    state = AsyncData(true);
  }

  Future<void> logout() async {
    final storage = await ref.read(localStorageServiceProvider.future);
    await storage.remove('authToken');
    state = AsyncData(false);
  }
}