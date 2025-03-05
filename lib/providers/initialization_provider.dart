// lib/providers/initialization_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../services/local_storage_service.dart';

part 'initialization_provider.g.dart';

@riverpod
class AppInitialization extends _$AppInitialization {
  // 在provider中添加计数器
  int _retryCount = 0;

  // 添加模拟错误标志（仅测试用）
  static const simulateError = true; // 设为false关闭模拟错误

  Future<void> _performInitialization() async {
    try {
      // 初始化存储服务
      await ref.read(localStorageServiceProvider.future);
      // 模拟数据库初始化
      await Future.delayed(const Duration(seconds: 1), () {
        print('Database initialized');
        //throw Exception('Database initialization failed');
      });

      // 3. 主动抛出错误（测试用）
      if (simulateError) {
        throw Exception('模拟初始化失败: 数据库连接超时');
      }
    } catch (e, st) {
      // 关键！必须通过 AsyncValue.error 传递错误
      return Future.error(e, st);
    }
  }

  @override
  Future<void> build() async {
    await _performInitialization();
    //state = await AsyncValue.guard(_performInitialization);

    // try {
    //   // 强制抛出测试异常
    //   throw Exception('人工触发初始化失败');
    //   // 实际初始化逻辑...
    // } catch (e, st) {
    //   // 关键！必须通过 AsyncValue.error 传递错误
    //   return Future.error(e, st);
    // }
  }

  // 添加重试方法
  Future<void> retry() async {
    if (_retryCount >= 3) {
      state = AsyncValue.error('Maximum retries exceeded', StackTrace.current);
      return;
    }
    _retryCount++;

    state = const AsyncValue.loading();
    try {
      await _performInitialization();
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}