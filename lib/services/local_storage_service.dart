// lib/services/local_storage_service.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'local_storage_service.g.dart';

@riverpod
class LocalStorageService extends _$LocalStorageService {
  SharedPreferences? _prefs;

  @override
  Future<SharedPreferences> build() async {
    return await _initialize();
  }

  Future<SharedPreferences> _initialize() async {
    return _prefs ??= await SharedPreferences.getInstance();
  }

  String? getAuthToken() {
    if (_prefs == null) throw Exception('Storage not initialized');
    return _prefs!.getString('authToken');
  }

  Future<void> saveAuthToken(String token) async {
    if (_prefs == null) throw Exception('Storage not initialized');
    await _prefs!.setString('authToken', token);
  }

  Future<void> deleteAuthToken() async {
    if (_prefs == null) throw Exception('Storage not initialized');
    await _prefs!.remove('authToken');
  }
}