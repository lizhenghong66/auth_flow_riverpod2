// lib/screens/splash_screen.dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/initialization_provider.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  void _showErrorDialog(
      BuildContext context,
      WidgetRef ref, // 添加ref参数
      Object error) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('初始化错误'),
        content: Text(error.toString()),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // 执行重试
              ref.read(appInitializationProvider.notifier).retry();
            },
            child: const Text('重试'),
          ),
          TextButton(
            //onPressed: () => Navigator.pop(context),
            onPressed: () {
              Navigator.pop(context);
              // 退出应用
              exit(0);
            },

            child: const Text('退出'),
          ),
        ],
      ),
    ).then((_) {
      // 重试初始化逻辑
      //ref.read(appInitializationProvider.notifier).retry();
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 强制重新构建的关键：使用 watch 而不是 read
    final initialization = ref.watch(appInitializationProvider);

    // 调试输出
    print('Initialization state: ${initialization}');
    print('Has error: ${initialization.hasError}');
    print('Is loading: ${initialization.isLoading}');

    // 使用 when 代替 whenOrNull 强制处理所有状态
    return initialization.when(
      loading: () => _buildLoading(context),
      error: (error, st) => _buildError(context, ref, error),
      data: (_) => _buildSuccess(),
    );
  }

  Widget _buildLoading(BuildContext context) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 20),
            Text(
              '正在初始化...',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ),
    );

  Widget _buildError(BuildContext ctx, WidgetRef ref, Object err) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showErrorDialog(ctx, ref, err);
    });
    return _buildLoading(ctx);
  }

  Widget _buildSuccess() => const SizedBox.shrink();
  // Widget build(BuildContext context, WidgetRef ref) {
  //   final initialization = ref.watch(appInitializationProvider);
  //
  //   initialization.whenOrNull(
  //     error: (error, stack) => _showErrorDialog(context, ref, error), // 传递ref
  //   );
  //
  //   return Scaffold(
  //     body: Center(
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           const CircularProgressIndicator(),
  //           const SizedBox(height: 20),
  //           Text(
  //             initialization.isLoading ? '正在初始化...' : '准备就绪!',
  //             style: Theme.of(context).textTheme.titleLarge,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
